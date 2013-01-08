express = require 'express'
app = express()

app.get '/', (req, res) -> res.send '<h1>Hello World</h1>'

app.listen process.env.PORT
