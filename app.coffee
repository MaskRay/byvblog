"use continuation"
http = require 'http'
path = require 'path'
express = require 'express'
connect_mongo = require 'connect-mongo'
config = require './config'
routes = require './routes'
jit = require './jit'

jit.configure
  continuation:
    src: path.join __dirname, 'assets', 'js'
    dest: path.join __dirname, 'public', 'js'

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
  
  app.use (req, res, next) ->
    res.locals.dateFormat = require('dateformat');
    res.locals.errors = ->
      error = req.session.error
      req.session.error = undefined
      error
    next()
  
  app.use app.router
  app.use express.static(path.join __dirname, 'public')

app.configure 'development', ->
  app.use express.errorHandler()

#TODO disable jit in production env
app.locals.assetsJit = (type, src, dest) ->
  jit.update type, src, dest
  return dest

routes app

jit obtain()

port = app.get 'port'
http.createServer(app).listen port, cont()
console.log "Express server listening on port " + port
