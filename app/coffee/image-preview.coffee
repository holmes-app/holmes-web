class HoverImage
  constructor: (@offsetX, @offsetY) ->
    @createElement()
    @bindEvents()

  createElement: ->
    @container = $('<div class="image-preview"></div>')
    $(document.body).append(@container)

  bindEvents: ->
    container = @container
    offset =
      x: @offsetX
      y: @offsetY

    $(document).on('mouseenter', 'a', (ev) ->
      x = ev.pageX
      y = ev.pageY

      link = $(ev.currentTarget)
      href = link.attr('href')

      updateContainerPosition = (xPos, yPos) ->
          container.css('top', yPos - offset.y)
          container.css('left', xPos - offset.x)

      if href
        extension = href.toLowerCase().substr(href.length - 4, 4)

        if extension == '.gif' or extension == '.png' or extension == '.jpg' or extension == '.jpeg' or extension == '.webp'
          container.html('<img src="' + href + '" />')
          updateContainerPosition(x, y)
          container.show()

      link.bind('mousemove', (ev) ->
        x = ev.pageX
        y = ev.pageY
        updateContainerPosition(x, y)
      )

      return true
    ).on('mouseleave', 'a', (ev) ->
      link = $(ev.currentTarget)
      link.unbind('mousemove')
      container.hide()
    )
 

hoverImage = new HoverImage(100, 0)
