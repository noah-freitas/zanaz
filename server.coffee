express = require 'express'
redis = require 'redis'
url = require 'url'

# Redis client.
redisURL = url.parse process.env.REDISCLOUD_URL
client = redis.createClient redisURL.port, redisURL.hostname, no_ready_check: true
client.auth redisURL.auth.split(':')[1]
client.on 'error', (err) -> console.log "Error #{err}"
client.set 'message', 'Hello World!'

# Express app.
app = express()
app.get '/', (req, res) ->
  client.get 'message', (err, reply) ->
    if err then console.log err
    res.send "<h1>#{reply}</h1>"

app.listen process.env.PORT
