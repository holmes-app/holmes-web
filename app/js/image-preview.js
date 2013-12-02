(function() {
  var HoverImage, hoverImage;

  HoverImage = (function() {
    function HoverImage(offsetX, offsetY) {
      this.offsetX = offsetX;
      this.offsetY = offsetY;
      this.createElement();
      this.bindEvents();
    }

    HoverImage.prototype.createElement = function() {
      this.container = $('<div class="image-preview"></div>');
      return $(document.body).append(this.container);
    };

    HoverImage.prototype.bindEvents = function() {
      var container, offset;
      container = this.container;
      offset = {
        x: this.offsetX,
        y: this.offsetY
      };
      return $(document).on('mouseenter', 'a', function(ev) {
        var extension, href, link, updateContainerPosition, x, y;
        x = ev.pageX;
        y = ev.pageY;
        link = $(ev.currentTarget);
        href = link.attr('href');
        updateContainerPosition = function(xPos, yPos) {
          container.css('top', yPos - offset.y);
          return container.css('left', xPos - offset.x);
        };
        if (href) {
          extension = href.toLowerCase().substr(href.length - 4, 4);
          if (extension === '.gif' || extension === '.png' || extension === '.jpg' || extension === '.jpeg' || extension === '.webp') {
            container.html('<img src="' + href + '" />');
            updateContainerPosition(x, y);
            container.show();
          }
        }
        link.bind('mousemove', function(ev) {
          x = ev.pageX;
          y = ev.pageY;
          return updateContainerPosition(x, y);
        });
        return true;
      }).on('mouseleave', 'a', function(ev) {
        var link;
        link = $(ev.currentTarget);
        link.unbind('mousemove');
        return container.hide();
      });
    };

    return HoverImage;

  })();

  hoverImage = new HoverImage(100, 0);

}).call(this);

/*
//@ sourceMappingURL=image-preview.js.map
*/