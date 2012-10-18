class Model
  constructor: (@id) ->

Model.url = ''
Model.attrs = []

Model.fetch = (id, next) ->
  self = this
  try
    Utils.get self.url + '/' + id, obtain(result)
    post = new self result.id
    for attr in self.attrs
      post[attr] = result[attr]
    next null, post
  catch err
    next err

window.Model = Model
