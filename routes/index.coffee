'use continuation'
fs = require 'fs'
Post = require '../models/post'
admin = require './admin'

module.exports = (app) ->
  app.get '/', (req, res, next) ->
    Post.find().limit(10).sort('-postTime').exec obtain posts
    res.render 'postslist',
      posts: posts
      
  admin app
  
  app.get /^\/api\/template\/(.+)$/ , (req, res, next) ->
    templateName = app.get('views') + '/' + req.params[0]
    console.log templateName
    
    fs.readFile templateName, obtain template
    res.send template
  
  app.get /^\/(.+)$/, (req, res, next) ->
    postId = req.params[0]
    Post.findOne {id: postId}, obtain post
    if post is null
      return next()
    res.render 'post',
      post: post
