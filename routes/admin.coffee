'use continuation'
User = require '../models/user'

module.exports = (app) ->
  app.get '/admin', (req, res, next) ->
    if not req.session.user?
      return res.redirect '/admin/login'
    res.json req.session.user
  
  app.get '/admin/login', (req, res, next) ->
    if req.session.user?
      return res.redirect '/admin'
    res.render 'admin/login'
  
  app.post '/admin/login', (req, res, next) ->
    User.authenticate req.body.user, cont(err, user)
    if err
      req.session.error = err
      res.render 'admin/login'
    else
      req.session.user = user
      res.redirect '/admin/new'
  
  app.get '/admin/logout', (req, res, next) ->
    req.session.user = undefined
    res.redirect '/admin'
  
  app.get '/admin/new', (req, res, next) ->
    res.render 'admin/editpost'
