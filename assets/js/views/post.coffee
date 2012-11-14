'use strict'
class Post extends View
  constructor: ->
    @prefix = '/api/template/'
    @file = 'includes/post.jade'

Post::_render = (post) ->
  self = this
  if not self.template?
    self.compile 'mixin post(post)'
  res = self.template post: post

Post::render = (post, next) ->
  self = this
  try
    self.initialize obtain()
    html = self._render post
    next null, html
  catch err
    return next err

Post::show = (post, next) ->
  self = this
  try
    self.initialize obtain()
    $('#main').html self._render post
    View.post.setListeners()
  catch err
    return next err
  next null

Post::setListeners = ->
  $('.post_header_link').each () ->
    postId = $(this).attr('data-post-id')
    $(this).click postId, (event) ->
      postId = event.data
      Controller.setState postId
      false

View.post = new Post

$ ->
  View.post.setListeners()
