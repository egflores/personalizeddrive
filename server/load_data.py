from peewee import *
from datetime import *

class BaseModel(Model):
    class Meta:
        //correct database model

class CarData(BaseModel):
    time = DateTimeField()
    mileage = IntegerField()

def create_tables():
    CarData.create_table()

//create_tables()

f = open('fakedata.txt')
for line in f.readlines():
    data = line.split(',');
    datetime_data = data[0]
    date = datetime_data.split('T')[0]
    year = date.split('-')[0]
    month = date.split('-')[1]
    day = date.split('-')[2]
    time = datetime_data.split('T')[1]
    hour = time.split(':')[0]
    minute = time.split(':')[1]
    second = time.split(':')[2]
    miles = data[1]
    result_date = datetime(int(year), int(month), int(day), int(hour), int(minute), int(second))
    entry = CarData.create(time = result_date, mileage = miles)
