do ($ = jQuery) ->

  $('.page-pages-index').find('main').each ->
    $this = $(@)

    $this.find('p:has(img)').each ->
      $this = $(@)
      $this.find('img').insertAfter($this)
      $this.remove()
