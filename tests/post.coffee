'use continuation'
Post = require '../models/post'

p = new Post
  id: 'first'
  title: '第一篇'
  author: 'byvoid'
  contents: 'neirong'

p.save obtain()
console.log p
