import random
from datetime import datetime, timedelta
from models import RawData

date = datetime(2013, 3, 25)
rdata = RawData.select().order_by(RawData.update_time.desc())
num = rdata.count()
for i in range(num):
    r = rdata[i]
    r.update_time = date;
    r.save()
    date -= timedelta(days=1)
