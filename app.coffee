"use continuation"
http = require 'http'
path = require 'path'
util = require 'util'
express = require 'express'
connect_mongo = require 'connect-mongo'
config = require './config'
routes = require './routes'

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
  app.use require('connect-assets')(src: path.join(__dirname, 'assets'))
  
  app.use (req, res, next) ->
    res.locals.dateFormat = require('dateformat');
    res.locals.inspect = util.inspect
    
    pathSec = req._parsedUrl.pathname.split '/'
    if pathSec[1] in config.languages
      pathStart = 2
      res.locals.language = pathSec[1]
    else
      pathStart = 1
      res.locals.language = null
    res.locals.postId = '/' + pathSec.slice(pathStart).join '/'
    
    res.locals.success = ->
      success = req.session.success
      req.session.success = undefined
      success
    res.locals.errors = ->
      error = req.session.error
      req.session.error = undefined
      error
    next()
  
  app.use app.router
  app.use express.static(path.join __dirname, 'public')

app.configure 'development', ->
  app.use express.errorHandler()

routes app

port = app.get 'port'
http.createServer(app).listen port, cont()
console.log "Express server listening on port " + port
