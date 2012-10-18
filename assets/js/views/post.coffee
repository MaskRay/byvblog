class Post extends View
  constructor: () ->
    @prefix = '/api/template/'
    @file = 'includes/post.jade'

View.post = new Post

Post::render = (post) ->
  self = this
  if not self.template?
    self.compile 'mixin post(post)'
  res = self.template post: post

Post::show = (post, next) ->
  self = this
  try
    self.initialize obtain()
    $('#contents').html self.render post
  catch err
    return next err
  next null

$ ->
  $('.post_header_link').each () ->
    postId = $(this).parent().parent().parent().attr('data-post-id')
    $(this).click postId, (event) ->
      postId = event.data
      Controller.setState postId
      false
