class Map
  attr_reader :start_x, :start_y, :zoom, :face, :need_redraw

  MAP = [
  [1,1,1,1,1,],
  [4,4,4,4,4,],
  [3,3,3,3,3,],
  [5,5,5,5,5,],
  [1,1,1,1,1,],
  ]

  enum asset_map

  def initialize
    @map = MAP
    @zoom = 1
    @faces = %i[north west south east]
    @face = @faces.first
    @start_x = 0
    @start_y = 0
    @local_x = 0
    @local_y = 0
    @need_redraw = true
  end

  def need_redraw!
    @need_redraw = true
  end

  def start_x=(x)
    @start_x = x
    need_redraw!
  end

  def start_y=(y)
    @start_y = y
    need_redraw!
  end

  def zoom_inc
    @zoom += 0.5 if @zoom <= 3
    need_redraw!
  end

  def zoom_dec
    @zoom -= 0.5 if @zoom > 0.5
    need_redraw!
  end

  def rotate_clockwise
    @map = @map.transpose.map(&:reverse)
    @faces.rotate!
    @face = @faces.first
    need_redraw!
  end

  def rotate_anticlockwise
    3.times do
      @map = @map.transpose.map(&:reverse)
      @faces.rotate!
    end
    @face = @faces.first
    need_redraw!
  end

  def show_grid(mouse_x, mouse_y)
    iso_x = @start_x + 32
    iso_y = @start_y

    iso_w = (128/2) * @zoom
    iso_h = (64/2) * @zoom

    local_x = ((mouse_y - iso_y) / iso_h + (mouse_x - iso_x) / iso_w) / 2;
    local_y = ((mouse_y - iso_y) / iso_h - (mouse_x - iso_x) / iso_w) / 2;

    if local_x != @local_x || local_y != local_y
      @local_x = local_x
      @local_y = local_y
      need_redraw!
    end
  end



  def draw
    return unless @need_redraw
    x = 0
    y = 0

    @map.each do |row|
      row.each do |col|
        t = Tile.new(col, x, y, @start_x, @start_y, zoom: @zoom, face: @face)
        t.draw
        t.draw_grade if x == @local_x.to_i && y == @local_y.to_i

        x += 1
      end
      x = 0
      y += 1
    end

    @need_redraw = false
  end
end