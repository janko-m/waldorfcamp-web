jQuery ->
  $('p:has(img)').each ->
    $(@).addClass 'img'
  $('p:has(iframe)').each ->
    $(@).addClass 'iframe'
