'use continuation'
Post = require '../models/post'
admin = require './admin'

module.exports = (app) ->
  app.get '/', displayPostList(false)
  app.get /^\/(.{2,3})\/$/, displayPostList(true)
  admin app
  app.get /^\/(.{2,3})\/(.+)$/, displayPost(true)
  app.get /^\/(.+)$/, displayPost(false)

displayPostList = (languageSpecified) ->
  (req, res, next) ->
    if languageSpecified
      language = req.params[0]
      if not (language in ['zhs', 'zht', 'en'])
        return next()
    else
      language = null
    Post.find({private:false, list:true}).limit(10).sort('-postTime').exec obtain posts
    Post.render posts, language, obtain(posts)
    res.render 'postslist',
      posts: posts

displayPost = (languageSpecified) ->
  (req, res, next) ->
    if languageSpecified
      language = req.params[0]
      postId = req.params[1]
      if not (language in ['zhs', 'zht', 'en'])
        return next()
    else
      language = null
      postId = req.params[0]
    
    Post.findOne {id: postId}, obtain post
    if post is null
      return next()
    
    if post.private and not req.session.user?
      #Forbid guest viewing private posts
      return next()
    
    if not req.session.user?
      #Inrecrese click count
      post.clicks += 1
      post.save obtain()

    post.render language, obtain(post)
    res.render 'post',
      post: post
