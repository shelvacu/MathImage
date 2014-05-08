MathImage
=========

Inspired by/idea copied from: https://github.com/ichub/MathCanvas

### Quickstart

If you want to start making cool images, just open up main.rb (or gif.rb if you want an animated version)
and change the lines shown

    def r(x,y,t)
      #Put your equation for Red value here
    end

    def g(x,y,t)
      #Put your equation for Green value here
    end

    def r(x,y,t)
      #Put your equation for Blue value here
    end

And by "equation" I mean "valid ruby code".

*x* and *y* are the coordinates of the pixel you are generating, starting at the top-left. *t* is only for gifs, and is whatever the current frame is. Values that are returned are then modulo 256.

If you don't know ruby, you can probably still do some stuff, just remember to always put 2.0 instead of 2, otherwise ruby uses integer division. Also, for sin use `Math.sin(x)`, for powers use `x**y`, and don't be afraid to use parentheses. Other than that, just regular math symbols. Try things like:

    Math.sin(x)**Math.sin(y)
    2.0**(x/100)+y
    x+y
    x/y
    Math.sin(t)