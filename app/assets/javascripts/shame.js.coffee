do ($ = jQuery) ->

  $el = $(".l-page-pages-index, .l-page-pages-workshop")

  if $el.length

    $(".l-main").find("p:has(img)").each (i) ->
      dir = if i%2 == 0 then "left" else "right"

      $(@).addClass("img pull-#{dir}")
