require 'ruby2d'

require_relative 'map'
require_relative 'tile'
require_relative 'asset'

@map = Map.new

@map.start_x = 300
@map.start_y = 0

on :key_held do |event|
  if event.key == 'a'
    @map.start_x -= 10
  elsif event.key == 'd'
    @map.start_x += 10
  elsif event.key == 'w'
    @map.start_y += 10
  elsif event.key == 's'
    @map.start_y -= 10
  end
end

on :mouse_move do |event|
  @map.show_grid(event.x, event.y)
end

on :key_down do |event|
  if event.key == 'q'
    @map.rotate_anticlockwise
  elsif event.key == 'e'
    @map.rotate_clockwise
  elsif event.key == '='
    @map.zoom_inc
  elsif event.key == '-'
    @map.zoom_dec
  end
end

update do
  if @map.need_redraw
    clear
    @map.draw
  end
end

set title: 'Isometric Ruby Engine'
show