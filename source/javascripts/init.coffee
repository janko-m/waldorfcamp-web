$ ->
  $('nav ol li').not(':last-child').after $('<li>&middot;</li>')
  $('a').pjax('#main')
