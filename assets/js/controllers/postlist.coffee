'use strict'
postListCache = {}

Controller.postList = (state, next) ->
  page = 1
  try
    if postListCache[page]?
      posts = postListCache[page]
    else
      Post.fetchList obtain(posts)
      postListCache[page] = posts
    View.postList.show posts, obtain()
  catch err
    return next err if next?
    console.error err
  
  next err if next?
