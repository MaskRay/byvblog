"use continuation"
http = require('http')
path = require('path')
express = require('express')
routes = require('./routes')
jit = require('./jit')

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join __dirname, 'public')

app.configure 'development', ->
  app.use express.errorHandler()

routes app

port = app.get('port')

jit
  continuation:
    src: path.join __dirname, 'assets', 'js'
    dest: path.join __dirname, 'public', 'js'
, obtain()

http.createServer(app).listen port, cont()
console.log "Express server listening on port " + port
