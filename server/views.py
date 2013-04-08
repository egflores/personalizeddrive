import json

from datetime import datetime
from flask import render_template, request, abort, jsonify

from app import app
from models import *

@app.route('/1.0/rawcardata/update', methods=['POST'])
def post_rawdata():
    if request.headers['Content-Type'] != 'application/json':
        abort(415) # invalid content type
         
    data = request.json['data']
    num_successful = 0
    vehicle = Car.get(id=data[0]['car_id'])
    ts = datetime.fromtimestamp(data[0]['timestamp'])
    commute_id = Commute.create(car=vehicle, timestamp = ts, duration = 0, ave_speed = 0, ave_mpg = 0, tank_used=0.0)
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
                r.commute = commute_id
                r.update_time = timestamp
            r.tank_level = rawdata['fuel_level']
            r.fuel_range = rawdata['fuel_range'] 
            r.fuel_reserve = rawdata['fuel_reserve']
            r.odometer = rawdata['odometer']
            r.headlights = rawdata['headlights']
            r.speed = rawdata['speed']
            r.latitude = rawdata['gps_lat']
            r.longitude = rawdata['gps_long']
            r.save()
            num_successful += 1
        except:
            pass
    commute = rawdata.select().where(RawData.commute=commute_id).order_by(RawData.update_time.desc())
    
    #update commute
    commute_id.duration
    cummute_id.ave_speed
    cummute_id.ave_mpg
    cummute_id.tank_used
    commute_id.save()
    return jsonify({'success': num_successful})        

def get_default_car():
    u = User.get(username='Jay')
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

    commutes = Commute.select().where(Commute.car==car).order_by(Commute.timestamp.desc())
    return render_template('dashboard.html', car_data=car_data, 
            car=get_default_car(), tank_level=newest_data.tank_level, 
            fuel_range=newest_data.fuel_range, name="one", commutes=commutes)
