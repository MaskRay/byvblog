mongoose = require '../lib/mongoose'

postSchema = new mongoose.Schema
  id:
    type: String
    unique: true
  title: String,
  author: String,
  contents: String,

module.exports = Post = mongoose.model 'Post', postSchema
