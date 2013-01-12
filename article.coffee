redisClient = require('./redis').client

# Add dummy data.
redisClient.hset 'articles/12-months-of-middleware', '12 Months of Middleware', Date(), redisClient.print
redisClient.zadd 'articles', 1, 'articles/12-months-of-middleware|12 Months of Middleware', redisClient.print

parseArticle = (article) ->
  arr = article.split '|'
  { path: arr[0], title: arr[1] }

exports.middleware = (req, res, next) ->
  console.log 'In article middleware'
  next()

exports.use = (app) ->
  # List view
  app.get '/articles', (req, res) ->
    redisClient.zrevrange 'articles', 0, -1, (err, reply) ->
      if err then console.log err
      articles = [parseArticle article for article in reply]
      res.send articles
      # res.render 'articles', articles: articles

  # Detail view
  app.get '/articles/:id', (req, res) ->
    res.send "This is the aricle page for #{req.param 'id'}"
