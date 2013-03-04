import json
from flask import Flask, render_template 
# from flask_peewee.db import Database
from peewee import Model, DateTimeField, IntegerField, MySQLDatabase

"""
DATABASE = {
    'engine': 'peewee.MySQLDatabase',
    'name': 'pd_test',
    'user': 'pd_tester',
    'passwd': 'Nuggets',
    'host': 'bmw.stanford.edu'
}
db = Database(app)
"""
DEBUG = True 
SECRET_KEY = 'StephenTrusheim'

app = Flask(__name__) 
app.config.from_object(__name__) 
db = MySQLDatabase('pd_test', user='pd_tester', passwd='Nuggets', host='bmw.stanford.edu')
db.connect()

class BaseModel(Model):
    class Meta:
        database = db

class CarData(BaseModel):
    time = DateTimeField()
    mileage = IntegerField()

def create_tables():
    CarData.create_table()

@app.route('/')
def home():
    values = []
    for row in CarData.select():
# values.append([row.time.isoformat(), row.mileage])
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
    app.run()

