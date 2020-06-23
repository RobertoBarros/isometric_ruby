class RoadBuilder
  def self.road(map, row, col, face)
    if map[row][col - 1] == 'R' || map[row][col + 1] == 'R'
      puts 'AQUI'
      Asset.get_by(:road, face.next)
    else
      Asset.get_by(:road, face.current)
    end

  end
end