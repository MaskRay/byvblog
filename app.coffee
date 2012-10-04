"use continuation"
http = require 'http'
path = require 'path'
express = require 'express'
connect_mongo = require 'connect-mongo'
config = require './config'
routes = require './routes'
jit = require './jit'

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.cookieParser()
  app.use express.session
    secret: config.cookie_secret,
    store: new connect_mongo(express) config.mongo
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join __dirname, 'public')

app.configure 'development', ->
  app.use express.errorHandler()

routes app

jit
  continuation:
    src: path.join __dirname, 'assets', 'js'
    dest: path.join __dirname, 'public', 'js'
, obtain()

port = app.get 'port'
http.createServer(app).listen port, cont()
console.log "Express server listening on port " + port