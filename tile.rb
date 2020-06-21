class Tile

  WIDTH = 128
  HEIGHT = 64

  IMAGE_WIDTH = 132
  IMAGE_HEIGHT = 99


  def initialize(id, row, col, start_x, start_y, zoom: 1, face: :north)

    @zoom = zoom
    @file = case id
            when 1 then Asset.get_by(:grass, face)
            when 2 then Asset.get_by(:road, face)
            end

    @x1 = start_x + ((row * (WIDTH/2) * @zoom) - ( col * (WIDTH/2) * @zoom))
    @y1 = start_y + ((row * (HEIGHT/2) * @zoom) +(col * (HEIGHT/2) * @zoom))


  end


  def draw
    i = Image.new(@file, x: @x1, y: @y1, width: IMAGE_WIDTH * @zoom, height: IMAGE_HEIGHT * @zoom)
  end

end