'use continuation'
Post = require '../models/post'
config = require '../config'

exports.displayPostList = (req, res, next) ->
  language = req.params[1]
  page = parseInt req.params[3]
  page = 1 if isNaN(page)
  
  if language? and not (language in config.languages)
    return next()
  
  Post.getPosts {private:false, list:true}, page, config.options.postsPerPage, obtain posts
  Post.render posts, language, obtain(posts)
  res.render 'postslist',
    posts: posts
    page: page

exports.displayPost = (req, res, next) ->
  language = req.params[1]
  postId = req.params[2]
  
  if language? and not (language in config.languages)
    return next()
  
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

exports.displayTag = (req, res, next) ->
  language = req.params[1]
  tagName = req.params[2]
  page = parseInt req.params[4]
  page = 1 if isNaN(page)
  
  if language? and not (language in config.languages)
    return next()
  
  Post.getPosts {private:false, list:true, tags:tagName}, page, config.options.postsPerPage, obtain posts
  Post.render posts, language, obtain(posts)
  res.render 'postslist',
    posts: posts
    page: page
