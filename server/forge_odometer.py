import random
from datetime import datetime, timedelta
from models import RawData

date = datetime(2012, 11, 15)
rdata = RawData.select().order_by(RawData.update_time.asc())
num = rdata.count()
odometer = rdata[0].odometer
for i in range(num):
    r = rdata[i]
    print "Setting id %d to %d" % (r.id, odometer)
    r.odometer = odometer
    r.update_time = date;
    r.save()
    choice = random.random()
    if choice > .28:
        odometer = random.randint(odometer + 30, odometer + 100)
    date += timedelta(days=1)
