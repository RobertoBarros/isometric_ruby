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
    end
  end
end