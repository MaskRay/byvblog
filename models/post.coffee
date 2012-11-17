'use continuation'
mongoose = require '../lib/mongoose'
translate = require '../lib/translate'
marked = require 'marked'

contentSchema = new mongoose.Schema
  title: String
  contents: String
  language: String

postSchema = new mongoose.Schema
  id:
    type: String
    index: true
    unique: true
  contents: [contentSchema]
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

parseContents = (contents) ->
  return [] if not contents
  filtered = []
  for content in contents
    if content.language
      filtered.push content
  filtered

Post.newPost = (rawPost, author, next) ->
  post = new Post
  post.author = author
  post.modify rawPost, next

Post.render = (posts) ->
  for post in posts
    post.render()

Post::modify = (rawPost, next) ->
  @id = rawPost.id
  @tags = parseTags rawPost.tags
  @clicks = rawPost.clicks
  @private = rawPost.private
  @list = rawPost.list
  @contentsFormat = rawPost.contentsFormat
  @contents = parseContents rawPost.contents
  if not @id or not @contents
    return next new Error('Required fields')
  @save cont(err, post)
  next err, post

Post::getContentsByLanguage = (language) ->
  for content in @contents
    if content.language is language
      return content
  null

Post::render = (language, next) ->
  self = this
  post = @toObject()
  rendered = false
  if @contentsFormat is 'markdown'
    for content, i in @contents
      if (content.language is language) or (not language and i is 0)
        post.title = content.title
        post.contents = marked content.contents
        rendered = true
        break
  if not rendered
    rendered = true
    if language is 'zhs'
      content = self.getContentsByLanguage 'zht'
      if content
        translate.zhtToZhs content.title, obtain(post.title)
        translate.zhtToZhs content.contents, obtain(post.contents)
        post.contents = marked content.contents
    #TODO other direction
  next null, post
