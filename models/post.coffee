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

Post.getPosts = (conditions, page, pageSize, next) ->
  page = 1 if page < 1
  skip = (page - 1) * pageSize
  Post.find(conditions).skip(skip).limit(pageSize).sort('-postTime').exec next

Post.getPopularPosts = (count, next) ->
  Post.find({private:false, list:true}).limit(count).sort('-clicks').exec next

parseTags = (tags) ->
  return [] if not tags
  tags = tags.split ','
  for i of tags
    tags[i] = tags[i].trim()
  tags

parseContents = (contents) ->
  return [] if not contents
  filtered = []
  for lang, content of contents
    if content.title
      content.language = lang
      filtered.push content
  filtered

Post.newPost = (rawPost, author, next) ->
  post = new Post
  post.author = author
  post.modify rawPost, next

Post.render = (posts, language, next) ->
  try
    for post, i in posts
      post.render language, obtain(posts[i])
    next null, posts
  catch err
    next err

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

  if language
    content = self.getContentsByLanguage language
  else
    content = self.contents[0]

  if content
    post.title = content.title
    post.contents = content.contents
    rendered = true

  if not rendered
    if language is 'zhs'
      content = self.getContentsByLanguage 'zht'
      if content
        translate.zhtToZhs content.title, obtain(post.title)
        translate.zhtToZhs content.contents, obtain(post.contents)
        post.contents = marked content.contents
        post.converted = 'opencc'
        rendered = true
    else if language is 'zht'
      content = self.getContentsByLanguage 'zhs'
      if content
        translate.zhsToZht content.title, obtain(post.title)
        translate.zhsToZht content.contents, obtain(post.contents)
        post.contents = marked content.contents
        post.converted = 'opencc'
        rendered = true
  
  if not rendered
    post.converted = 'translate'
    post.title = 'Not implemented'
    post.contents = 'Not implemented'
    #TODO google translate API

  if self.contentsFormat is 'markdown'
    post.contents = marked post.contents
  next null, post
