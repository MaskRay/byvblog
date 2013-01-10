'use continuation'
RSS = require 'rss'
Post = require '../models/post'
config = require '../config'

exports.feed = (req, res, next) ->
  language = req.params[1]
  if language? and not (language in config.languages)
    return next()
  
  Post.getPosts {private:false, list:true}, 1, config.options.feedPosts, obtain posts
  Post.render posts, language, obtain(posts)
  feed = new RSS({
    title: config.site.title
    description: config.site.description
    author: config.site.author
    site_url: config.site.url
    feed_url: config.site.url + 'feed'
    image_url: 'http://example.com/icon.png'
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
