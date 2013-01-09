#= require jquery-1.8.2
#= require highlight.min
#= require yepnope
#= require modernizr-2.6.2
#= require jquery.tipsy
#= require jquery.flexslider
#= require jquery.prettyPhoto
#= require jquery.quovolver
#= require behaviours

$ = jQuery
$ ->
  hljs.initHighlightingOnLoad()
  $('.tab_content').hide()
  $('ul.tabs li:first').addClass('active').show()
  $('.tab_content:first').show()

$('ul.tabs li').click ->
  $('ul.tabs li').removeClass('active')
  $(this).addClass('active')
  $('.tab_content').hide()
  activeTab = $(this).find('a').attr('href')
  $(activeTab).fadeIn()
  return false
