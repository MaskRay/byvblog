"use continuation"
http = require 'http'
path = require 'path'
util = require 'util'
express = require 'express'
connect_mongo = require 'connect-mongo'
config = require './config'
routes = require './routes'
helper = require './middlewares/helper'

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.cookieParser()
  MongoStore = connect_mongo(express)
  app.use express.session
    secret: config.cookie_secret,
    store: new MongoStore(config.mongo)
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use require('connect-assets')
    src: path.join __dirname, 'assets'
    buildDir: 'public'
  app.use helper
  app.use app.router
  app.use express.static(path.join __dirname, 'public')

app.configure 'development', ->
  app.use express.errorHandler()

routes app

port = app.get 'port'
http.createServer(app).listen port, cont()
console.log "Express server listening on port " + port
