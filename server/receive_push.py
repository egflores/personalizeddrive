import random
from datetime import datetime
from models import RawData, Commute, Car

rdata = RawData.select().order_by(RawData.update_time.desc())
old = rdata[0]
new = RawData()
new.car = old.car
new.update_time = datetime.utcnow()
new.tank_level = old.tank_level - 2;
new.fuel_range = old.fuel_range - 5;
new.fuel_reserve = old.fuel_reserve;
new.odometer = old.odometer + random.randint(30, 100)
new.ave_mpg = old.ave_mpg 
new.headlights = old.headlights
new.speed = old.speed
new.engine_status = old.engine_status
new.save()

car = Car.get(id=1)
c = Commute(car=car, timestamp=datetime.utcnow(), duration=37, ave_speed=67, ave_mpg=32, tank_used=1)
c.save()
