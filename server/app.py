import json
from flask import Flask, render_template 
from flask_peewee.db import Database

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

@app.route('/')
def home():
    sample_data = {
        'data': [
            {
                'key': 'MPG',
                'values': [
                    [0, 100],
                    [100, 200]
                ]
            }
        ]
    }
    car_data = json.dumps(sample_data)
    return render_template('index.html', car_data=car_data)

if __name__ == '__main__':
    app.run()

