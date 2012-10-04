$('.post_header_link').each () ->
  postId = $(this).parent().parent().parent().attr('data-post-id')
  $(this).click postId, (event) ->
    loadPost event.data
    false

loadPost = (postId, next) ->
  try
    Post.fetch postId, obtain post
  catch err
    console.error err
    return next err if next?

  View.post.initialize obtain()
  $('#contents').html View.post.render(post)
  history.pushState post.id, null, post.id

  next null, post if next?

changeState = (state, data) ->
  return if not state?
  console.log 'Change to state:', state

window.onpopstate = (event) ->
  changeState event.state

null
