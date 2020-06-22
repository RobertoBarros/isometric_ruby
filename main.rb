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
      t.draw_grade if x == @local_x.to_i && y == @local_y.to_i

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


on :mouse_move do |event|

  global_x = event.x
  global_y = event.y

  iso_x = @start_x + 32
  iso_y = @start_y

  iso_w = (128/2) * @zoom
  iso_h =  (64/2) * @zoom

  @local_x = ((global_y - iso_y) / iso_h + (global_x - iso_x) / iso_w) / 2;
  @local_y = ((global_y - iso_y) / iso_h - (global_x - iso_x) / iso_w) / 2;
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
  Text.new("MOUSE: [#{@local_x.to_i},#{@local_y.to_i}]")
  tick += 1
end

set title: 'Isometric Ruby Engine'
show