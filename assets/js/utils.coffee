class Utils

Utils.get = (url, next) ->
  request = $.ajax({
    type: 'GET'
    url: url
  })
  request.done (result) ->
    next null, result
  request.fail (jqXHR) ->
    next jqXHR

window.Utils = Utils
