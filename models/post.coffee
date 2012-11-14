'use continuation'
mongoose = require '../lib/mongoose'
marked = require 'marked'

postSchema = new mongoose.Schema
  id:
    type: String
    index: true
    unique: true
  title: String
  contents: String
  contentsFormat: String
  author: String
  postTime: Date
  clicks:
    type: Number
    index: true
  tags: 
    type: [String]
    index: true
  private:
    type: Boolean
    index: true
  list:
    type: Boolean
    index: true

module.exports = Post = mongoose.model 'Post', postSchema

postSchema.pre 'save', (next) ->
  if not @postTime?
    @postTime = new Date
  if not @clicks?
    @clicks = 0
  if not @private?
    @private = false
  if not @list?
    @list = false
  if not @clicks
    @clicks = 0
  next()

parseTags = (tags) ->
  return [] if not tags
  tags = tags.split ','
  for i of tags
    tags[i] = tags[i].trim()
  tags

Post.newPost = (rawPost, author, next) ->
  post = new Post
  post.author = author
  post.modify rawPost, next

Post.render = (posts) ->
  for post in posts
    post.render()

Post::modify = (rawPost, next) ->
  @id = rawPost.id
  @title = rawPost.title
  @contents = rawPost.contents
  @tags = parseTags rawPost.tags
  @clicks = rawPost.clicks
  @private = rawPost.private
  @list = rawPost.list
  @contentsFormat = rawPost.contentsFormat
  if not @id or not @title or not @contents?
    return next new Error('Required fields')
  @save next

Post::render = ->
  if @contentsFormat is 'markdown'
    @contents = marked @contents
