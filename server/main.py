from app import app, db

from auth import *
from admin import admin
from models import *
from views import *

admin.setup()

def create_tables():
    User.create_table(fail_silently=True)
    Car.create_table(fail_silently=True)
    Commute.create_table(fail_silently=True)
    CBSMessage.create_table(fail_silently=True)
    CCMMessage.create_table(fail_silently=True)
    RawData.create_table(fail_silently=True)
    auth.User.create_table(fail_silently=True)

if __name__ == '__main__':
    create_tables()
    print "Running Drei with DEBUG=%s" % app.config.get('DEBUG', '')
    app.run()
