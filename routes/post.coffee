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
  Post.getPopularPosts config.options.popularPosts, obtain popularPosts
  Post.getArchive obtain archives
  Post.getRecentPosts config.options.recentPosts, obtain recentPosts
  
  res.render 'postslist',
    posts: posts
    popularPosts: popularPosts
    archives: archives
    recentPosts: recentPosts
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
  
  Post.getPopularPosts config.options.popularPosts, obtain popularPosts
  Post.getArchive obtain archives
  Post.getRecentPosts config.options.recentPosts, obtain recentPosts
  
  post.render language, obtain(post)
  res.render 'post',
    post: post
    popularPosts: popularPosts
    archives: archives
    recentPosts: recentPosts

exports.displayTag = (req, res, next) ->
  language = req.params[1]
  tagName = req.params[2]
  page = parseInt req.params[4]
  page = 1 if isNaN(page)
  if language? and not (language in config.languages)
    return next()
  
  Post.getPosts {private:false, list:true, tags:tagName}, page, config.options.postsPerPage, obtain posts
  Post.render posts, language, obtain(posts)
  Post.getPopularPosts config.options.popularPosts, obtain popularPosts
  Post.getArchive obtain archives
  Post.getRecentPosts config.options.recentPosts, obtain recentPosts
  
  res.render 'postslist',
    posts: posts
    popularPosts: popularPosts
    archives: archives
    recentPosts: recentPosts
    page: page

exports.archive = (req, res, next) ->
  language = req.params[1]
  year = parseInt req.params[2]
  month = parseInt req.params[3]
  page = parseInt req.params[5]
  page = 1 if isNaN(page)
  if language? and not (language in config.languages)
    return next()
  
  start = new Date(year, month - 1, 1)
  month++
  if month > 12
    year++
    month = 1
  end = new Date(year, month - 1, 1)
  
  cond =
    private: false
    list: true
    postTime:
      $gte: start
      $lt: end
  Post.getPosts cond, page, config.options.postsPerPage, obtain posts
  Post.render posts, language, obtain(posts)
  Post.getPopularPosts config.options.popularPosts, obtain popularPosts
  Post.getArchive obtain archives
  Post.getRecentPosts config.options.recentPosts, obtain recentPosts
  
  res.render 'postslist',
    posts: posts
    popularPosts: popularPosts
    archives: archives
    recentPosts: recentPosts
    page: page

exports.tagList = (req, res, next) ->
  language = req.params[1]
  if language? and not (language in config.languages)
    return next()
  
  Post.getTags obtain tags
  Post.getPopularPosts config.options.popularPosts, obtain popularPosts
  Post.getArchive obtain archives
  Post.getRecentPosts config.options.recentPosts, obtain recentPosts
  
  res.render 'taglist',
    tags: tags
    popularPosts: popularPosts
    archives: archives
    recentPosts: recentPosts
