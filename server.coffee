express = require 'express'
article = require './article'
redisClient = require('./redis').client

# Redis client.
redisClient.set 'message', 'Hello World!'

# Express app.
app = express()
app.use article
app.get '/', (req, res) ->
  redisClient.get 'message', (err, reply) ->
    if err then console.log err
    res.send "<h1>#{reply}</h1>"

app.listen process.env.PORT
