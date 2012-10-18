'use strict'
class View
  constructor: (@prefix, @file) ->
    @fetched = false
    @data = ''
    @template = null

View::initialize = (next) ->
  self = this
  if @fetched
    next() if next
    return
  
  try
    Utils.get self.prefix + self.file, obtain(result)
    self.data = result
    self.fetched = true
    next() if next?
  catch err
    next err

View::compile = (suffix) ->
  suffix = '' if not suffix?
  @template = jade.compile @data + '\n' + suffix,
    filename: @file

View::_render = (locals) ->
  if not @template?
    this.compile()
  @template locals

window.View = View
