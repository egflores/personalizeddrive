from app.py import User, Car, Commute, CBSMessage, CCMMessage, RawData
import json
import requests
from datetime import datetime

def parseTime(data):
    """ Creates a datetime object from the REST result """
    t = data[0]['updateTime']
    date = t.split('T')[0]
    year = date.split('-')[0]
    month = date.split('-')[1]
    day = date.split('-')[2]
    time = t.split('T')[1]
    time = time.split('+')[0]
    hour = time.split(':')[0]
    minute = time.split(':')[1]
    second = time.split(':')[2]
    return datetime(int(year), int(month), int(day), int(hour), int(minute), int(second))

def loadRaw(data, vehicle):
    """ Inserts a row into RawData table """
    result = RawData.get(car == vehicle).order_by(RawData.update_time.desc())
    fuel = data[0]['remainingFuel']
    miles = data[0]['milage']
    mpg = 0.0
    if (len(result) == 0):
        mpg = 20
    else:
        total_mpg = 0.0
        for stat in result:
            total_mpg += stat.ave_mpg
        fuel_used = result[0].remaining_fuel - fuel
        miles_driven = miles - result[0].milage
        mpg = double(miles_driven/fuel_used)
        total_mpg += mpg
        mpg /= (len(result) + 1)
    time = parseTime(data)
    RawData.create(car = vehicle, remaining_fuel = fuel, remaining_range_fuel = data[0]['remainingRangeFuel'], range_unit = data[0]['rangeUnit'], mileage = miles, ave_mpg = mpg, update_time = time)
    
def loadCCM(data, vehicle):
    # iterate through all messages and insert
    CCMMessage.create(car = vehicle, type = , state)

def loadCBS(data, vehicle):
    # interate through all message and insert
    CBSMessage.create()    

def refresh(vehicle_id):
    address = '/api/v1/user/vehicles/' + vehicle_id + '/status'
    r = requests.get(address)
    data = json.loads(r.json())
    vehicle = Car.get(Car.vehicle_id == vehicle_id)
    loadRaw(data, vehicle)
    loadCCM(data, vehicle)
    loadCBS(data, vehicle)
