'use continuation'
Post = require '../models/post'

module.exports = (app) ->
  app.get '/', (req, res, next) ->
    Post.find().limit(10).sort('-postTime').exec obtain posts
    res.render 'postslist',
      posts: posts

  app.get '/:postId', (req, res, next) ->
    postId = req.params.postId
    Post.findOne {id: postId}, obtain post
    if post is null
      return next()
    res.render 'post',
      post: post

  app.get '/api/post/:postId', (req, res, next) ->
    postId = req.params.postId
    Post.findOne {id: postId}, obtain post
    if post is null
      return next()
    res.json post
