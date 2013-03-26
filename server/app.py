from flask import Flask
from flask_peewee.db import Database
from werkzeug.contrib.fixers import ProxyFix

app = Flask(__name__) 
# app.config.from_object('config.Configuration') 
app.config.from_object('config.LocalConfiguration') 
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
