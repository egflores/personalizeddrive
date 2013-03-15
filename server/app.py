import json
from flask import Flask, render_template, request, abort, jsonify
from flask_peewee.db import Database
from flask_peewee.auth import Auth, BaseUser
from flask_peewee.admin import Admin, ModelAdmin
from peewee import DateTimeField, IntegerField, ForeignKeyField, \
        DoubleField, CharField, TextField, BooleanField
from datetime import datetime
from werkzeug.contrib.fixers import ProxyFix

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
try:
    # tries to load config from an env variable
    # that will override the settings declared in this file
    # eventually, when we use chef or some deploy tool
    # we shouldn't have to do this. 
    app.config.from_envvar('PRODUCTION_SETTINGS')
except:
    pass

app.wsgi_app = ProxyFix(app.wsgi_app) # makes app work on gunicorn
db = Database(app)

class CarData(db.Model):
    """ Just a Sample Model For Testing"""
    time = DateTimeField()
    mileage = IntegerField()

class Admins(db.Model, BaseUser):
    username = CharField(unique=True)
    password = CharField()
    email = CharField()
    admin = BooleanField()
    active = BooleanField(default=False)

class User(db.Model):
    first_name = CharField()
    last_name = CharField()
    password = TextField()

class UserAdmin(ModelAdmin):
    columns = ('first_name', 'last_name', 'password')

class Car(db.Model):
    user = ForeignKeyField(User, related_name="cars", index=True)
    vehicle_id = CharField()
    model = CharField()
    year = IntegerField()
    name = CharField()
    picture = TextField(null=True)

class CarAdmin(ModelAdmin):
    columns = ('user', 'vehicle_id', 'model', 'year', 'name', 'picture');

class Commute(db.Model):
    car = ForeignKeyField(Car, related_name="commutes", index=True)
    trip_mpg = DoubleField()
    trip_mileage = DoubleField()
    duration = IntegerField()

class CommuteAdmin(ModelAdmin):
    columns = ('car', 'trip_mpg', 'trip_milage', 'duration')

class CBSMessage(db.Model):
    car = ForeignKeyField(Car, related_name="cbs_messages", index=True)
    type = CharField()
    state = CharField()
    description = TextField()
    remaining_mileage = IntegerField(null=True)
    due_date = DateTimeField(null=True)
    update_time = DateTimeField(index=True)

class CBSMessageAdmin(ModelAdmin):
    columns = ('car', 'type', 'state', 'description', 'remaining_mileage', 'due_date', 'update_time')

class CCMMessage(db.Model):
    car = ForeignKeyField(Car, related_name="ccm_messages", index=True)
    ccm_id = IntegerField()
    mileage = IntegerField()
    description = TextField()
    update_time = DateTimeField(index=True)

class CCMMessageAdmin(ModelAdmin):
    columns = ('car', 'ccm_id', 'mileage', 'description', 'update_time')

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

class RawDataAdmin(ModelAdmin):
    columns = ('car', 'update_time', 'tank_level', 'fuel_range', 'fuel_reserve', 'odometer', 'ave_mpg', 'headlights', 'speed', 'engine_status')

### admin setup 
auth = Auth(app, db, Admins)
admin = Admin(app, auth)
auth.register_admin(admin)
admin.register(User, UserAdmin)
admin.register(Car, CarAdmin)
admin.register(RawData, RawDataAdmin)
admin.register(CCMMessage, CCMMessageAdmin)
admin.register(CBSMessage, CBSMessageAdmin)
admin.register(Commute, CommuteAdmin)
admin.setup()
### setup end

@app.route('/1.0/rawcardata/update', methods=['POST'])
def post_rawdata():
    if request.headers['Content-Type'] != 'application/json':
        abort(415) # invalid content type
         
    data = request.json['data']
    num_successful = 0
    for rawdata in data:
        try:
            c = Car.get(id=rawdata['car_id'])
            timestamp = datetime.fromtimestamp(rawdata['timestamp'])
            r = None
            try:
                r = RawData.get(car=c, update_time=timestamp)
            except RawData.DoesNotExist:
                r = RawData()
                r.car = c
                r.update_time = timestamp
            r.tank_level = rawdata['fuel_level']
            r.fuel_range = rawdata['fuel_range'] 
            r.fuel_reserve = rawdata['fuel_reserve']
            r.odometer = rawdata['odometer']
            r.headlights = rawdata['headlights']
            r.speed = rawdata['speed']
            r.save()
            num_successful += 1
        except:
            pass
    return jsonify({'success': num_successful})        

def get_default_car():
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
    return render_template('sample.html', car_data=car_data, 
            car=get_default_car(), name="two")

@app.route('/')
def dashboard():
    values = []
    car = get_default_car()
    rawdata = RawData.select().where(RawData.car==car).order_by(
            RawData.update_time.desc())
    if rawdata.count() == 0:
        return "Invalid Car"

    values = [(int(r.update_time.strftime("%s")), r.odometer) for r in rawdata]

    car_data = {
        'data': [
            {
                'key': 'Mileage',
                'values': values
            }
        ]
    }
    newest_data = rawdata[0]
    return render_template('dashboard.html', car_data=car_data, 
            car=get_default_car(), tank_level=newest_data.tank_level, 
            fuel_range=newest_data.fuel_range, name="one")

print "Running Drei with DEBUG=%s" % app.config.get('DEBUG', '')

if __name__ == '__main__':
    User.create_table(fail_silently=True)
    Car.create_table(fail_silently=True)
    Commute.create_table(fail_silently=True)
    CBSMessage.create_table(fail_silently=True)
    CCMMessage.create_table(fail_silently=True)
    RawData.create_table(fail_silently=True)
    auth.User.create_table(fail_silently=True)

    app.run()
