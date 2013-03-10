import json
from flask import Flask, render_template 
from flask_peewee.db import Database
from peewee import DateTimeField, IntegerField, ForeignKeyField, DoubleField, CharField, TextField

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
    picture = TextField()

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
    car = ForeignKeyField(Car, related_name="raw_data", index=True)
    remaining_fuel = IntegerField() # in liters
    remaining_range_fuel = IntegerField()
    range_unit = CharField()
    mileage = IntegerField()
    ave_mpg = DoubleField()
    update_time = DateTimeField(index=True) 

@app.route('/')
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
    return render_template('index.html', car_data=car_data)

if __name__ == '__main__':
    User.create_table(fail_silently=True)
    Car.create_table(fail_silently=True)
    Commute.create_table(fail_silently=True)
    CBSMessage.create_table(fail_silently=True)
    CCMMessage.create_table(fail_silently=True)
    RawData.create_table(fail_silently=True)

    app.run()

