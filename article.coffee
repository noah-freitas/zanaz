redisClient = require('./redis').client

redisClient.hset 'articles/12-months-of-middleware', '12 Months of Middleware', Date(), redisClient.print
redisClient.zadd 'articles', 1, 'articles/12-months-of-middleware', redisClient.print

exports.middleware = (req, res, next) ->
  console.log 'In article middleware'
  next()

exports.use = (app) ->
  # List view
  app.get '/articles', (req, res) ->
    redisClient.zrevrange 'articles', 0, -1, (err, reply) ->
      if err then console.log err
      console.log reply

  # Detail view
  app.get '/articles/:id', (req, res) ->
    res.send "This is the aricle page for #{req.param 'id'}"
