'use continuation'
Post = require '../models/post'

module.exports = (app) ->
  app.get '/', (req, res) ->
    res.render 'index', title: 'Express'

  app.get '/:postId', (req, res, next) ->
    postId = req.params.postId
    Post.findOne {id: postId}, obtain post
    if post is null
      return next()
    res.render 'post',
      title: post.title
      post: post

  app.get '/api/post/:postId', (req, res) ->
    postId = req.params.postId
    Post.findOne {id: postId}, obtain post
    if post is null
      return next()
    res.json post
