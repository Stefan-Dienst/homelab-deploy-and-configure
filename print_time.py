import sys
import time
from datetime import datetime

while True:
    current_time = datetime.now()
    print(current_time.strftime("%Y-%m-%d %H:%M:%S"))
    sys.stdout.flush()
    time.sleep(1)
