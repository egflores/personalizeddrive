from flask_peewee.auth import BaseUser
from peewee import *
from passlib.hash import bcrypt

from app import db

class User(db.Model, BaseUser):
    username = CharField(unique=True)
    password = CharField()
    email = CharField()
    admin = BooleanField()
    active = BooleanField(default=False)

    def set_password(self, password):
        self.password = bcrypt.encrypt(password)

    def check_password(self, password):
        return bcrypt.verify(password, self.password)
        
    def hash_password(self, password):
        return bcrypt.encrypt(password)
        
    def hash_user(self):
        return bcrypt.encrypt(self.username + self.password)
        
    def verify_hash(self, hash):
        return hash == self.hash_user();

class Car(db.Model):
    user = ForeignKeyField(User, related_name="cars", index=True)
    vehicle_id = CharField()
    model = CharField()
    year = IntegerField()
    name = CharField()
    picture = TextField(null=True)

class Commute(db.Model):
    car = ForeignKeyField(Car, related_name="commutes", index=True)
    timestamp = DateTimeField()
    duration = IntegerField() # in minutes
    ave_speed = DoubleField() # in mph
    ave_mpg = DoubleField() # average mpg
    tank_used = DoubleField() # number of gallons used
    start_latitude = DoubleField(null=True) # Latitude at beginning of commute
    start_longitude = DoubleField(null=True) # Longitude at beginning of commute
    end_latitude = DoubleField(null=True) # Latitude at end commute 
    end_longitude = DoubleField(null=True) # Longitude at end of commute
    
class CBSMessage(db.Model):
    car = ForeignKeyField(Car, related_name="cbs_messages", index=True)
    type = CharField()
    state = CharField()
    description = TextField()
    remaining_mileage = IntegerField(null=True)
    due_date = DateTimeField(null=True)
    update_time = DateTimeField(index=True)

class CCMMessage(db.Model):
    car = ForeignKeyField(Car, related_name="ccm_messages", index=True)
    ccm_id = IntegerField()
    mileage = IntegerField()
    description = TextField()
    update_time = DateTimeField(index=True)

class RawData(db.Model):

    FUEL_RESERVE_ENUM = ['no', 'yes', 'invalid']
    ENGINE_STATUS_ENUM = ['off', 'starting', 'running', 'invalid']
    HEADLIGHTS_ENUM = ['on', 'off']

    # foreign key to car table
    car = ForeignKeyField(Car, related_name="raw_data", index=True)
    commute = ForeignKeyField(Commute, related_name="raw_data", index=True)
    
    # update time (when this data was calculated)
    update_time = DateTimeField(index=True) 

    # amount of gas in tank, in gallons
    tank_level = IntegerField(null=True) # amount of gas in tank, in gallons

    # number of miles that can be travelled on the current tank
    fuel_range = IntegerField(null=True) 

    # whether the tank is on fuel reserve
    fuel_reserve = CharField(null=True, 
            choices=[(c, c) for c in FUEL_RESERVE_ENUM])

    # mileage count of car
    odometer = IntegerField()

    # average miles per gallon of the car, at this time
    ave_mpg = DoubleField(null=True)

    # whether the headlights are on or not
    headlights = CharField(null=True, 
            choices=[(c, c) for c in HEADLIGHTS_ENUM])

    # current speed of the car
    speed = DoubleField(null=True)

    # current status of the Engine
    engine_status = CharField(null=True, 
            choices=[(c, c) for c in ENGINE_STATUS_ENUM])
    
    latitude = DoubleField()
    longitude = DoubleField()
