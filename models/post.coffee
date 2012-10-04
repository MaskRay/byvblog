mongoose = require '../lib/mongoose'

postSchema = new mongoose.Schema
  id:
    type: String
    index: true
    unique: true
  title: String,
  author: String,
  contents: String,
  postTime: Date,

module.exports = Post = mongoose.model 'Post', postSchema

postSchema.pre 'save', (next) ->
  if not @postTime
    @postTime = new Date;
  next()
