from flask import Flask
from flask_peewee.db import Database
from werkzeug.contrib.fixers import ProxyFix

app = Flask(__name__) 
app.config.from_object('config.Configuration') 
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

print "Running Drei with DEBUG=%s" % app.config.get('DEBUG', '')

def create_tables():
    User.create_table(fail_silently=True)
    Car.create_table(fail_silently=True)
    Commute.create_table(fail_silently=True)
    CBSMessage.create_table(fail_silently=True)
    CCMMessage.create_table(fail_silently=True)
    RawData.create_table(fail_silently=True)
    auth.User.create_table(fail_silently=True)
