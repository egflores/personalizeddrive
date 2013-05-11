import json

from datetime import datetime
from flask import render_template, request, abort, jsonify, redirect, url_for

from app import app
from auth import auth
from models import *

@app.route('/login', methods=['POST'])
def auth_login():
    if request.headers['Content-Type'] != 'application/json':
        abort(415) # invalid content type
    
    data = request.json['login']
    user = User.get(User.username==data[0]['username'])
    if user.check_password(user.hash_password(data[0]['password'])):
        return jsonify({'token': user.hash_user()})
    return jsonify({'user': data[0]['username'], 'token':''})
    
@app.route('/2.0/rawcardata/update', methods=['POST'])
def post_rawdata():
    if request.headers['Content-Type'] != 'application/json':
        abort(415) # invalid content type
         
    data = request.json['values']
    user_id = request.json['user_id']
    car_id = request.json['car_id']
    num_successful = 0
    vehicle = Car.get(id=car_id)
    ts = datetime.fromtimestamp(data[0]['timestamp'])
    commute_id = Commute.create(car=vehicle, timestamp = ts, duration = 0, ave_speed = 0, ave_mpg = 0, tank_used=0.0)
    for rawdata in data:
        try:
            c = vehicle
            timestamp = datetime.fromtimestamp(rawdata['timestamp'])
            r = None
            try:
                r = RawData.get(car=c, update_time=timestamp)
            except RawData.DoesNotExist:
                r = RawData()
                r.car = c
                r.update_time = timestamp
            r.commute = commute_id
            r.tank_level = rawdata['fuel_level']
            r.speed = rawdata['vehicle_speed']
            r.latitude = rawdata['gps_latitude']
            r.longitude = rawdata['gps_longitude']
            # need to add relative distance
            # need to add engine fuel rate
            # need to rpm
            # need to add instant mpg
            r.save()
            num_successful += 1
        except:
            pass
    commute = RawData.select().where(RawData.commute==commute_id).order_by(RawData.update_time.asc())
    count = commute.count()
    duration = commute[count - 1].update_time - commute[0].update_time
    duration = duration.total_seconds() / 60
    commute_id.duration = duration
    speed = 0.0
    for data in commute:
        speed += data.speed
        #need to add instant speed to get ave_mpg
    commute_id.ave_speed = speed / count
    #commute_id.tank_used = first fuel level - last fuel level
    commute_id.save()
    return jsonify({'success': num_successful})        

@app.route('/2.0/drivelogs', methods=['GET'])
def get_drivelogs():
    if request.headers['Content-Type'] != 'application/json':
        abort(415) # invalid content type

    data = request.json['token']    
    user = User.get(User.username==data[0]['username'])
    if user.verify_hash(data[0][token])
        car = get_default_car() 
        commutes = Commute.select().where(Commute.car==car).order_by(Commute.timestamp.desc())
        commute_data = []
        for c in commutes:
            commute_data.append({
                'timestamp': c.timestamp.isoformat(),
                'duration': c.duration,
                'ave_speed': c.ave_speed,
                'ave_mpg': c.ave_mpg,
                'tank_used': c.tank_used,
            })
        return jsonify({'drive_logs': commute_data})
    return jsonify({'error': 'invalid token'})

@app.route('/accounts/signup/', methods=['GET', 'POST'])
def sign_up():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        pwd = request.form['password']
        confirm_pwd = request.form['password']
        if (pwd != confirm_pwd):
            render_template('auth/signup.html')
        else:
            u = User(username=username, password='', email=email, 
                    admin=False, active=True)
            u.set_password(pwd)
            u.save()
            auth.login_user(u)
            return redirect(url_for('dashboard'))
    else:
        return render_template('/auth/signup.html')

def get_default_car():
    u = auth.get_logged_in_user()
    c = Car.get(id=1)
    return c

@app.route('/')
@auth.login_required
def dashboard():
    values = []
    car = get_default_car()
    rawdata = RawData.select().where(RawData.car==car).order_by(
            RawData.update_time.desc())
    if rawdata.count() == 0:
        return "Invalid Car"

    odoms = [(int(r.update_time.strftime("%s")), r.odometer) for r in rawdata]
    speeds = [(int(r.update_time.strftime("%s")), r.speed) for r in rawdata]
    fuels = [(int(r.update_time.strftime("%s")), r.tank_level) for r in rawdata]

    car_data = {
        'data': [
            {
                'key': 'Fuel Level',
                'values': fuels
            },
		  {
			'key': 'Speed',
			'values': speeds
            }
        ]
    }
    newest_data = rawdata[0]

    commutes = Commute.select().where(Commute.car==car).order_by(Commute.timestamp.desc())
    return render_template('dashboard.html', car_data=car_data, 
            car=get_default_car(), tank_level=newest_data.tank_level, 
            fuel_range=newest_data.fuel_range, name="one", commutes=commutes)
