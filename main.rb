require 'ruby2d'
require_relative 'tile'
require_relative 'asset'

MAP = [
[2,2,2,2,2,],
[1,1,2,1,1,],
[1,2,2,2,1,],
[1,1,1,1,1,],
[1,1,2,2,2,],
]

def draw_map(pos_x, pos_y, map, zoom, face)
  x = 0
  y = 0

  map.each do |row|
    row.each do |col|

      t = Tile.new(col, x, y, pos_x, pos_y, zoom: zoom, face: face)
      t.draw

      # puts "x=#{x} y=#{y}"
      # file = case col
      #        when 1 then 'assets/landscape/landscapeTiles_075.png'
      #        when 2 then 'assets/landscape/landscapeTiles_037.png'
      #        when 3 then 'assets/landscape/landscapeTiles_044.png'
      #        when 4 then 'assets/landscape/landscapeTiles_045.png'
      #        when 5 then 'assets/landscape/landscapeTiles_052.png'
      #        end

      # x1 = pos_x + ((x * 64)-(y*64))
      # y1 = pos_y + ((y * 32)+(x * 32))

      # x2 = (pos_x + 1) + ((x * 64)-(y*64))
      # y2 = (pos_y + 1) + ((y * 32)+(x * 32))

      # x3 = (pos_x + 1) + ((x * 64)-(y*64))
      # y3 = (pos_y + 1) + ((y * 32)+(x * 32))


      # Image.new(file, x: x1, y: y1)

      #   Line.new(
      #     x1: x1 + 64, y1: y1,
      #     x2: x2, y2: y2 + 32,
      #     color: 'white',
      #     width: 0.5
      #   )

      x += 1
    end
    x = 0
    y += 1
  end
end

@start_x = 300
@start_y = 0
@zoom = 1
@map = MAP
@faces = %i[north west south east]


on :key_held do |event|
  if event.key == 'a'
    @start_x -= 10
  elsif event.key == 'd'
    @start_x += 10
  elsif event.key == 'w'
    @start_y += 10
  elsif event.key == 's'
    @start_y -= 10
  end
end


on :key_down do |event|
  if event.key == 'q'
    3.times do
      @map = @map.transpose.map(&:reverse)
      @faces.rotate!
    end
  elsif event.key == 'e'
    @map = @map.transpose.map(&:reverse)
    @faces.rotate!
  elsif event.key == '='
    @zoom += 0.5 if @zoom <= 3
  elsif event.key == '-'
    @zoom -= 0.5 if @zoom > 0.5
  end
end

tick = 0
update do
  clear
  draw_map(@start_x, @start_y, @map, @zoom, @faces.first)
  tick += 1
end

set title: 'Isometric Ruby Engine'
show