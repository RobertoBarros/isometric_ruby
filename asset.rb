class Asset

  PATH = "assets/landscape/landscapeTiles_%s.png"

  ASSETS = {
    grass: {
      north: PATH % '075',
      south: PATH % '075',
      east:  PATH % '075',
      west:  PATH % '075',
    },
    road: {
      north: PATH % '074',
      south: PATH % '074',
      east:  PATH % '082',
      west:  PATH % '082',
    },
    road_end_left: {
      north: PATH % '105',
      south: PATH % '112',
      east:  PATH % '117',
      west:  PATH % '111',
    },
    road_end_right: {
      north: PATH % '112',
      south: PATH % '105',
      east:  PATH % '111',
      west:  PATH % '117',
    },
    road_large_center: {
      north: PATH % '081',
      south: PATH % '081',
      east:  PATH % '081',
      west:  PATH % '081',
    },
    road_large_left: {
      north: PATH % '080',
      south: PATH % '095',
      east:  PATH % '087',
      west:  PATH % '088',
    },
    road_large_right: {
      north: PATH % '095',
      south: PATH % '080',
      east:  PATH % '088',
      west:  PATH % '087',
    }
  }




  def self.get_by(id, face)
    ASSETS[id][face]
  end
end