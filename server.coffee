express = require 'express'
article = require './article'
redisClient = require('./redis').client

# Redis client.
redisClient.set 'message', 'Hello World!'

# Express app.
app = express()

# Add our middleware.
app.configure ->
  app.use express.favicon './public/favicon.ico'
  app.use app.router

article.use app

app.get '/', (req, res) ->
  redisClient.get 'message', (err, reply) ->
    if err then console.log err
    res.send "<h1>#{reply}</h1>"

app.listen process.env.PORT
