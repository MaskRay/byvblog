'use continuation'
RSS = require 'rss'
Post = require '../models/post'
admin = require './admin'
config = require '../config'

module.exports = (app) ->
  app.get /^\/((.{2,3})\/|)$/, displayPostList
  app.get /^\/((.{2,3})\/|)feed$/, displayFeed
  app.get /^\/((.{2,3})\/|)blog\/tag\/(.+)$/, displayTag
  admin app
  app.get /^\/((.{2,3})\/|)(.+)$/, displayPost

displayPostList = (req, res, next) ->
  language = req.params[1]
  
  if language? and not (language in config.languages)
    return next()
  
  Post.find({private:false, list:true}).limit(config.options.postsPerPage).sort('-postTime').exec obtain posts
  Post.render posts, language, obtain(posts)
  res.render 'postslist',
    posts: posts

displayFeed = (req, res, next) ->
  language = req.params[1]
  
  if language? and not (language in config.languages)
    return next()

  Post.find({private:false, list:true}).limit(config.options.feedPosts).sort('-postTime').exec obtain posts
  Post.render posts, language, obtain(posts)
  feed = new RSS({
    title: 'byvblog'
    description: 'desc'
    feed_url: config.site.url + 'feed'
    site_url: config.site.url
    image_url: 'http://example.com/icon.png'
    author: config.site.author
  })
  
  for post in posts
    feed.item
      title: post.title
      description: post.contents
      url: config.site.url + post.id
      guid: '111'
      author: config.site.author
      date: post.postTime
  
  xml = feed.xml()
  res.end xml

displayPost = (req, res, next) ->
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

displayTag = (req, res, next) ->
  language = req.params[1]
  tagName = req.params[2]
  
  if language? and not (language in config.languages)
    return next()

  Post.find({private:false, list:true, tags:tagName}).limit(10).sort('-postTime').exec obtain posts
  
  Post.render posts, language, obtain(posts)
  res.render 'postslist',
    posts: posts
