class Post extends Model

Post.url = '/api/post'
Post.attrs = ['title', 'author', 'contents', 'postTime']

window.Post = Post
