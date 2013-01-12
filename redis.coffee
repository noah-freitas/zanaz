url = require 'url'
redis = require 'redis'

redisURL = url.parse process.env.REDISCLOUD_URL
client = redis.createClient redisURL.port, redisURL.hostname, no_ready_check: true
client.auth redisURL.auth.split(':')[1]
client.on 'error', (err) -> console.log "Error #{err}"

exports.client = client
exports.print = redis.print
