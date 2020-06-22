class Asset
  def self.get_by(id, face)
    case id
    when :grass
      'assets/landscape/landscapeTiles_075.png'
    when :road
      case face
      when :north, :south
        'assets/landscape/landscapeTiles_074.png'
      when :east, :west
        'assets/landscape/landscapeTiles_082.png'
      end
    when :road_center
      'assets/landscape/landscapeTiles_081.png'
    when :road_left
      case face
      when :north
        'assets/landscape/landscapeTiles_080.png'
      when :south
        'assets/landscape/landscapeTiles_095.png'
      when :east
        'assets/landscape/landscapeTiles_087.png'
      when :west
        'assets/landscape/landscapeTiles_088.png'
      end
    when :road_right
      case face
      when :north
        'assets/landscape/landscapeTiles_095.png'
      when :south
        'assets/landscape/landscapeTiles_080.png'
      when :east
        'assets/landscape/landscapeTiles_088.png'
      when :west
        'assets/landscape/landscapeTiles_087.png'
      end
    end
  end
end