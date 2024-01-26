import time
import os


env_value = os.environ['SAT_MODE_INFO']

print('test')
print(f"env_value = {env_value}")

f= open("env_check_in_run.txt","w+")
f.write(f"{env_value}\r\n")
f.close()

i = 0
while i <= 0:
    time.sleep(1)