class Model
  constructor: (@id) ->

Model.url = ''
Model.attrs = []

Model.fetch = (id, next) ->
  self = this
  
  request = $.ajax({
    type: 'GET'
    url: self.url + '/' + id
  })
  
  request.done (result) ->
    post = new self result.id;
    for attr in self.attrs
      post[attr] = result[attr]
    next null, post
  
  request.fail (jqXHR) ->
    next jqXHR

window.Model = Model
