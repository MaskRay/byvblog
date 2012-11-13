'use continuation'
mongoose = require '../lib/mongoose'

postSchema = new mongoose.Schema
  id:
    type: String
    index: true
    unique: true
  title: String
  author: String
  contents: String
  postTime: Date
  clicks: Number
  tags: [String]
  private: Boolean

module.exports = Post = mongoose.model 'Post', postSchema

postSchema.pre 'save', (next) ->
  if not @postTime?
    @postTime = new Date
  if not @clicks?
    @clicks = 0
  if not @private?
    @private = true
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

Post::modify = (rawPost, next) ->
  @id = rawPost.id
  @title = rawPost.title
  @contents = rawPost.contents
  @tags = parseTags rawPost.tags
  if not @id or not @title or not @contents?
    return next new Error('Required fields')
  @save next
