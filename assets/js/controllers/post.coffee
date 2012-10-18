'use strict'
postCache = {}

Controller.loadPost = (postId, next) ->
  try
    if postCache[postId]?
      post = postCache[postId]
    else
      Post.fetch postId, obtain post
      postCache[postId] = post
    View.post.show post, obtain()
    next null, post if next?
  catch err
    next err if next?
