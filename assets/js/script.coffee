#= require jquery-1.8.2
#= require highlight.min
#= require yepnope
#= require modernizr-2.6.2
#= require jquery.tipsy
#= require jquery.flexslider
#= require jquery.prettyPhoto
#= require jquery.quovolver
#= require jquery.fancybox-1.3.4
#= require behaviours

$ = jQuery
$ ->
  hljs.initHighlightingOnLoad()
  $('.tab_content').hide()
  $('ul.tabs li:first').addClass('active').show()
  $('.tab_content:first').show()
  resizeImages()

$('ul.tabs li').click ->
  $('ul.tabs li').removeClass('active')
  $(this).addClass('active')
  $('.tab_content').hide()
  activeTab = $(this).find('a').attr('href')
  $(activeTab).fadeIn()
  return false

resizeImages = ->
  maxWidth = $('#content article .entry-body').width() - 10
  $('#content article img').each (id, img) ->
    img = $(img)
    if img.width() > maxWidth
      ratio = img.width() / img.height()
      img.width maxWidth
      img.height maxWidth / ratio
    link = img.parent()
    if link.prop('tagName').toLowerCase() is 'a'
      link.fancybox
        transitionIn: 'elastic'
        transitionOut: 'elastic'
