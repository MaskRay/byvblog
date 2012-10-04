'use continuation'
fs = require 'fs'
Post = require '../models/post'

module.exports = (app) ->
  app.get '/', (req, res, next) ->
    Post.find().limit(10).sort('-postTime').exec obtain posts
    res.render 'postslist',
      posts: posts

  app.get '/api/post/:postId', (req, res, next) ->
    postId = req.params.postId
    Post.findOne {id: postId}, obtain post
    if post is null
      return next()
    res.json post
  
  app.get /^\/api\/template\/(.+)$/ , (req, res, next) ->
    templateName = app.get('views') + '/' + req.params[0]
    console.log templateName
    
    fs.readFile templateName, obtain template
    res.send template
  
  app.get '/:postId', (req, res, next) ->
    postId = req.params.postId
    Post.findOne {id: postId}, obtain post
    if post is null
      return next()
    res.render 'post',
      post: post
