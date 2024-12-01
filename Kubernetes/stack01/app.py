from flask import Flask
from redis import Redis
import os
import socket
 
app = Flask(__name__)
redis = Redis(host='redis-service', port=6379)
 
@app.route('/')
def hello():
    # Increment the 'hits' counter in Redis
    count = redis.incr('hits')
   
    # Create the HTML response
    html = "<h3>Hello {name}!</h3>" \
           "<b>Hostname:</b> {hostname}<br/>" \
           "<b>Visits:</b> {count}"
    return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(), count=count)
 
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5010, debug=True)