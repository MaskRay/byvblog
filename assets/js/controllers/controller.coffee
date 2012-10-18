'use strict'
class Controller

Controller.initialize = ->
  Controller.routes =
    'postlist':   ['']
    '*':          ['*', Controller.loadPost]

Controller.getStateInfo = (state) ->
  info = Controller.routes[state]
  if not info
    #If not found in routes list, post
    info = Controller.routes['*']
  path = info[0]
  path = state if path is '*'
  state: state
  path: path
  handler: info[1]

Controller.setState = (state) ->
  stateInfo = Controller.getStateInfo state
  Controller.onChangeState state, stateInfo, obtain()
  history.pushState state, null, stateInfo.path

Controller.onChangeState = (state, stateInfo, next) ->
  console.log stateInfo.state
  if stateInfo.handler?
    stateInfo.handler state, next
  else
    next null if next?

window.onpopstate = (event) ->
  state = event.state
  return if not state?
  stateInfo = Controller.getStateInfo state
  Controller.onChangeState state, stateInfo

$ ->
  console.log 'refresh'
  Controller.initialize()

window.Controller = Controller
