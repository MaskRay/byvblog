'use strict'
class PostList extends View
  constructor: ->


PostList::show = (posts, next) ->
  try
    html = ''
    for post in posts
      View.post.render post, obtain(postHtml)
      html += postHtml
    $('#contents').html html
    View.post.setListeners()
    next null
  catch err
    next err

PostList::setListeners = ->
  $('#index_link').click (event) ->
    Controller.setState 'postlist'
    false

View.postList = new PostList

$ ->
  View.postList.setListeners()
