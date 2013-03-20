from flask_peewee.admin import Admin, ModelAdmin

from app import app, db
from auth import auth
from models import *

class CarAdmin(ModelAdmin):
    columns = ('user', 'vehicle_id', 'model', 'year', 'name', 'picture');

class CommuteAdmin(ModelAdmin):
    columns = ('car', 'trip_mpg', 'trip_milage', 'duration')

class CBSMessageAdmin(ModelAdmin):
    columns = ('car', 'type', 'state', 'description', 'remaining_mileage', 'due_date', 'update_time')

class CCMMessageAdmin(ModelAdmin):
    columns = ('car', 'ccm_id', 'mileage', 'description', 'update_time')

class RawDataAdmin(ModelAdmin):
    columns = ('car', 'update_time', 'tank_level', 'fuel_range', 'fuel_reserve', 'odometer', 'ave_mpg', 'headlights', 'speed', 'engine_status')

admin = Admin(app, auth)
auth.register_admin(admin)
admin.register(Car, CarAdmin)
admin.register(RawData, RawDataAdmin)
admin.register(CCMMessage, CCMMessageAdmin)
admin.register(CBSMessage, CBSMessageAdmin)
admin.register(Commute, CommuteAdmin)
