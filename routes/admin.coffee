'use continuation'
User = require '../models/user'
Post = require '../models/post'

exports.index = (req, res, next) ->
  if not req.session.user?
    return res.redirect '/admin/login'
  Post.find().sort('-postTime').exec obtain posts
  res.render 'admin/postslist',
    posts: posts

exports.loginPage = (req, res, next) ->
  if req.session.user?
    return res.redirect '/admin'
  res.render 'admin/login'

exports.login = (req, res, next) ->
  User.authenticate req.body.user, cont(err, user)
  if err
    req.session.error = err.toString()
    res.render 'admin/login'
  else
    req.session.user = user
    res.redirect '/admin'

exports.logout = (req, res, next) ->
  req.session.user = undefined
  res.redirect '/admin'

exports.newPostPage = (req, res, next) ->
  if not req.session.user?
    return res.redirect '/admin/login'
  res.render 'admin/editpost',
    post: null

exports.newPost = (req, res, next) ->
  if not req.session.user?
    return res.redirect '/admin/login'
  author = req.session.user.name
  Post.newPost req.body.post, author, cont(err, post)
  if err
    req.session.error = err.toString()
    return res.redirect '/admin/new'
  req.session.success = 'Post saved'
  res.redirect '/admin/edit/' + post.id

exports.editPostPage = (req, res, next) ->
  if not req.session.user?
    return res.redirect '/admin/login'
  postGuid = req.params[0]
  Post.findOne {guid: postGuid}, cont(err, post)
  return next err if err
  return next new Error('Invalid post id') if not post?

  #Organize by languages
  post = post.toObject()
  post.contents ?= []
  languages = {}
  for contents in post.contents
    languages[contents.language] = contents
  post.contents = languages
    
  res.render 'admin/editpost',
    post: post
  
exports.editPost = (req, res, next) ->
  if not req.session.user?
    return res.redirect '/admin/login'
  postGuid = req.params[0]
  try
    Post.findOne {guid: postGuid}, obtain(post)
    throw new Error('Invalid post id') if not post?
    post.modify req.body.post, obtain(savedPost)
    req.session.success = 'Post saved'
    res.redirect '/admin/edit/' + savedPost.guid
  catch err
    req.session.error = err.toString()
    res.render 'admin/editpost',
      post: post
