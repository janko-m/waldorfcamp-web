jQuery ->
  $('p:has(img)').each ->
    $(@).addClass 'img'
