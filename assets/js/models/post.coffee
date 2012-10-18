class Post extends Model

Post.url = '/api/post'
Post.attrs = ['title', 'author', 'contents', 'postTime']

Post.listUrl = '/api/postlist'

Post.fetchList = (next) ->
  self = this
  try
    Utils.get self.listUrl, obtain(results)
    posts = []
    for result in results
      post = new self result.id
      for attr in self.attrs
        post[attr] = result[attr]
      posts.push post
    next null, posts if next?
  catch err
    next err if next?

window.Post = Post
