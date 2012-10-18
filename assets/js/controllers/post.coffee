postCache = {}

Controller.loadPost = (postId, next) ->
  if postCache[postId]?
    next null, postCache[postId] if next?
    return
  
  try
    Post.fetch postId, obtain post
    View.post.show post, obtain()
  catch err
    return next err if next?
    console.error err

  postCache[postId] = post
  next null, post if next?
