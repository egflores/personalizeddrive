from flask_peewee.auth import BaseUser
from peewee import *

from app import db

class User(db.Model, BaseUser):
    username = CharField(unique=True)
    password = CharField()
    email = CharField()
    admin = BooleanField()
    active = BooleanField(default=False)

class Car(db.Model):
    user = ForeignKeyField(User, related_name="cars", index=True)
    vehicle_id = CharField()
    model = CharField()
    year = IntegerField()
    name = CharField()
    picture = TextField(null=True)

class Commute(db.Model):
    car = ForeignKeyField(Car, related_name="commutes", index=True)
    trip_mpg = DoubleField()
    trip_mileage = DoubleField()
    duration = IntegerField()

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
