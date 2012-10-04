config = require '../config'
mongoose = module.exports = require 'mongoose'

mongoose.connect 'mongodb://' + config.mongo.host + ':' + config.mongo.port + '/' + config.mongo.db
mongoose.connected = false
mongoose.connection.on 'open', ->
  mongoose.connected = true
