'use continuation'
User = require '../models/user'
Post = require '../models/post'

module.exports = (app) ->
  app.get '/admin/', (req, res, next) ->
    if not req.session.user?
      return res.redirect '/admin/login'
    Post.find().sort('-postTime').exec obtain posts
    res.render 'admin/postslist',
      posts: posts
  
  app.get '/admin/login', (req, res, next) ->
    if req.session.user?
      return res.redirect '/admin/'
    res.render 'admin/login'
  
  app.post '/admin/login', (req, res, next) ->
    User.authenticate req.body.user, cont(err, user)
    if err
      req.session.error = err.toString()
      res.render 'admin/login'
    else
      req.session.user = user
      res.redirect '/admin/'
  
  app.get '/admin/logout', (req, res, next) ->
    req.session.user = undefined
    res.redirect '/admin/'
  
  app.get '/admin/new', (req, res, next) ->
    if not req.session.user?
      return res.redirect '/admin/login'
    res.render 'admin/editpost',
      post: null
    
  app.post '/admin/new', (req, res, next) ->
    if not req.session.user?
      return res.redirect '/admin/login'
    author = req.session.user.name
    Post.newPost req.body.post, author, cont(err, post)
    if err
      req.session.error = err.toString()
      return res.redirect '/admin/new'
    res.redirect '/admin/edit/' + post.id
  
  app.param 'postId', (req, res, next, postId) ->
    Post.findOne {id: postId}, cont(err, post)
    return next err if err
    return next new Error('Invalid post id') if not post?
    req.post = post
    next()
    
  app.get '/admin/edit/:postId', (req, res, next) ->
    if not req.session.user?
      return res.redirect '/admin/login'
    res.render 'admin/editpost',
      post: req.post
  
  app.post '/admin/edit/:postId', (req, res, next) ->
    if not req.session.user?
      return res.redirect '/admin/login'
    req.post.modify req.body.post, cont(err, post)
    res.redirect '/admin/edit/' + post.id