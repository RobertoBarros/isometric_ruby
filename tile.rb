class Tile

  WIDTH = 128
  HEIGHT = 64

  IMAGE_WIDTH = 132
  IMAGE_HEIGHT = 99


  def initialize(asset, row, col, start_x, start_y, zoom: 1)
    @zoom = zoom
    @asset = asset

    @x1 = start_x + ((row - col) * WIDTH/2 * @zoom)
    @y1 = start_y + ((row + col) * HEIGHT/2 * @zoom)
  end


  def draw
    Image.new( @asset,
               x: @x1,
               y: @y1,
               width: IMAGE_WIDTH * @zoom,
               height: IMAGE_HEIGHT * @zoom)
  end

  def draw_grade
    x1 = @x1 + (WIDTH/2) * @zoom
    y1 = @y1

    x2 = x1 + (WIDTH/2) * @zoom
    y2 = y1 + (HEIGHT/2) * @zoom

    x3 = x2 - (WIDTH/2) * @zoom
    y3 = y2 + (HEIGHT/2) * @zoom

    x4 = x3 - (WIDTH/2) * @zoom
    y4 = y3 - (HEIGHT/2) * @zoom

    Quad.new(
      x1: x1, y1: y1,
      x2: x2, y2: y2,
      x3: x3, y3: y3,
      x4: x4, y4: y4,
      color: 'red',
      opacity: 0.2
    )



  end

end