require_relative 'face'
require_relative 'tile'
require_relative 'road_builder'
require_relative 'asset'

class Map
  attr_reader :start_x, :start_y, :zoom, :face, :need_redraw

  MAP = [
  %w[G G G G G],
  %w[G G G G G],
  %w[G G R R G],
  %w[G G G G G],
  %w[G G G G G],
  ]

  ASSET_MAP = {
    'G' => :grass,
    'R' => :road,
    3 => :road_large_center,
    4 => :road_large_left,
    5 => :road_large_right,
    6 => :road_end_left,
    7 => :road_end_right,
  }

  def initialize
    @map = MAP
    @zoom = 1
    @face = Face.new
    @start_x = 0
    @start_y = 0
    @local_x = -1
    @local_y = -1
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
    @face.rotate_clockwise
    need_redraw!
  end

  def rotate_anticlockwise
    3.times do
      @map = @map.transpose.map(&:reverse)
      @face.rotate_anticlockwise
    end
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

    (0..@map.size - 1).each do |row|
      (0..@map[row].size - 1).each do |col|

        if @map[row][col] == 'R'
          asset = RoadBuilder.road(MAP, row, col, @face)
        else
          asset = Asset.get_by(ASSET_MAP[@map[row][col]], @face.current)
        end

        t = Tile.new(asset, row, col, @start_x, @start_y, zoom: @zoom)
        t.draw
        t.draw_grade if row == @local_x.to_i && col == @local_y.to_i
      end
    end

    @need_redraw = false
  end
end