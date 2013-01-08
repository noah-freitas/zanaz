express = require 'express'
redis = require 'redis-url'

# Redis client.
client = redis.connect process.env.MYREDIS_URL
client.on 'error', (err) -> console.log "Error #{err}"
client.set 'message', 'Hello World!'

# Express app.
app = express()
app.get '/', (req, res) -> res.send "<h1>#{client.get 'message'}</h1>"
app.listen process.env.PORT
