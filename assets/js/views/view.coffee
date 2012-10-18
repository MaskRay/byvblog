class View
  constructor: (@prefix, @file) ->
    @fetched = false
    @data = ''
    @template = null

View::initialize = (next) ->
  if @fetched
    next() if next
    return
  
  self = this
  request = $.ajax({
    type: 'GET'
    url: self.prefix + self.file
  })
  
  request.done (result) ->
    self.data = result
    self.fetched = true
    next() if next?
  
  request.fail (jqXHR) ->
    if next?
      next jqXHR
    else
      throw jqXHR

View::compile = (suffix) ->
  suffix = '' if not suffix?
  @template = jade.compile @data + '\n' + suffix,
    filename: @file

View::render = (locals) ->
  if not @template?
    this.compile()
  @template locals

window.View = View
