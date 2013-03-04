from flask import Flask
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
def hello_world():
    return 'Hello World!'

if __name__ == '__main__':
    app.run()
