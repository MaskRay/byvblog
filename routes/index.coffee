post = require('./post')
admin = require('./admin')

routes =
  '^\/((.{2,3})\/|)(page\/(\d{1,4})|)$':
    GET: post.displayPostList
  '^\/((.{2,3})\/|)feed$':
    GET: post.displayFeed
  '^\/((.{2,3})\/|)blog\/tag\/(.+?)(\/page\/(\d{1,4})|)$':
    GET: post.displayTag
  '^\/admin$':
    GET: admin.index
  '^\/admin\/login$':
    GET: admin.loginPage
    POST: admin.login
  '^\/admin\/logout$':
    GET: admin.logout
  '^\/admin\/new$':
    GET: admin.newPostPage
    POST: admin.newPost
  '^\/admin\/edit\/(.+)$':
    GET: admin.editPostPage
    POST: admin.editPost
  '^\/((.{2,3})\/|)(.+)$':
    GET: post.displayPost

module.exports = (app) ->
  for path, methods of routes
    for method, handler of methods
      app[method.toLowerCase()] new RegExp(path), handler
