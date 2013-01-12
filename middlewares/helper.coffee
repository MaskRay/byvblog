util = require 'util'
config = require '../config'
zhsMsg = require '../locale/zhs'
zhtMsg = require '../locale/zht'
dateFormat = require('dateformat')

monthText = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月']

module.exports = (req, res, next) ->
  res.locals.dateFormat = dateFormat
  res.locals.inspect = util.inspect

  pathSec = req._parsedUrl.pathname.split '/'
  if pathSec[1] in config.languages
    pathStart = 2
    language = pathSec[1]
  else
    pathStart = 1
    language = null
  res.locals.language = language
  res.locals.postId = '/' + pathSec.slice(pathStart).join '/'

  res.locals.success = ->
    success = req.session.success
    req.session.success = undefined
    success
  res.locals.errors = ->
    error = req.session.error
    req.session.error = undefined
    error

  res.locals.langLink = (suffix) ->
    suffix = '/' + language + suffix if (language)
    suffix

  res.locals.postTitle = (post) ->
    for content in post.contents
      if content.language is language
        return content.title
    post.contents[0].title

  res.locals.label = (text) ->
    if language is 'zht' or not language
      label = zhtMsg[text.toLowerCase()]
    else if language is 'zhs'
      label = zhsMsg[text.toLowerCase()]
    if not label?
      label = text
    label

  res.locals.monthText = (date) ->
    if language is 'en'
      text = dateFormat(date, 'mmmm')
    else
      text = monthText[date.getMonth()]
    text

  toChineseNumeral = (num) ->
    digits = '〇一二三四五六七八九'
    if num < 10
      digits[num]
    else
      toChineseNumeral(Math.floor(num/10)) + digits[num%10]

  res.locals.monthYearText = (date) ->
    if language is 'en'
      text = dateFormat(date, 'mmmm yyyy')
    else
      text = toChineseNumeral(date.getFullYear()) + '年' + monthText[date.getMonth()]
    text

  next()
