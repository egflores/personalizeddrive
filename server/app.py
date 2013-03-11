import json
from flask import Flask, render_template 
from flask_peewee.db import Database
from peewee import DateTimeField, IntegerField, ForeignKeyField, \
        DoubleField, CharField, TextField

DATABASE = {
    'engine': 'peewee.MySQLDatabase',
    'name': 'pd_test',
    'user': 'pd_tester',
    'passwd': 'Nuggets',
    'host': 'bmw.stanford.edu'
}
DEBUG = True 
SECRET_KEY = 'StephenTrusheim'

app = Flask(__name__) 
app.config.from_object(__name__) 
db = Database(app)

class CarData(db.Model):
    """ Just a Sample Model For Testing"""
    time = DateTimeField()
    mileage = IntegerField()

class User(db.Model):
    first_name = CharField()
    last_name = CharField()
    password = TextField()

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
    tank_level = IntegerField() # amount of gas in tank, in gallons

    # number of miles that can be travelled on the current tank
    fuel_range = IntegerField() 

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

def getdefaultcar():
    u = User.get(first_name="Jay", last_name="Borenstein")
    c = Car.get(user=u)
    return c

@app.route('/sample')
def home():
    values = []
    for row in CarData.select():
        values.append([int(row.time.strftime("%s")), row.mileage])

    sample_data = {
        'data': [
            {
                'key': 'Mileage',
                'values': values
            }
        ]
    }
    car_data = json.dumps(sample_data)
    return render_template('sample.html', car_data=car_data, car=getdefaultcar(), name="two")

@app.route('/dashboard')
def dashboard():
    values = []
    for row in CarData.select():
        values.append([int(row.time.strftime("%s")), row.mileage])

    sample_data = {
        'data': [
            {
                'key': 'Mileage',
                'values': values
            }
        ]
    }
    car_data = json.dumps(sample_data)
    return render_template('dashboard.html', car_data=car_data, car=getdefaultcar(), name="one")

if __name__ == '__main__':
    User.create_table(fail_silently=True)
    Car.create_table(fail_silently=True)
    Commute.create_table(fail_silently=True)
    CBSMessage.create_table(fail_silently=True)
    CCMMessage.create_table(fail_silently=True)
    RawData.create_table(fail_silently=True)

    app.run()
