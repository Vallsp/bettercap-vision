import requests
from requests.auth import HTTPBasicAuth
import json
import time

username = 'user'
password = 'pass'

bettercap_api = 'http://localhost:8081/api/session'
logstash_endpoint = 'http://localhost:5044'

while True:
    response = requests.get(bettercap_api, auth=HTTPBasicAuth(username, password))
    data = response.json()
    requests.post(logstash_endpoint, json=data)
    # print(data)
    time.sleep(10)  # Polling interval
