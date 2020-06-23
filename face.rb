class Face
  FACES = %i[north west south east]

  def initialize(face: :north)
    @current_index = FACES.index(face)
  end

  def current
    FACES[@current_index]
  end

  def rotate_clockwise
    @current_index = increment_index
  end

  def rotate_anticlockwise
    @current_index = decrement_index
  end

  def next
    FACES[increment_index]
  end

  def previus
    FACES[decrement_index]
  end

  private

  def increment_index
    @current_index == FACES.count - 1 ? 0 : @current_index + 1
  end

  def decrement_index
    @current_index == 0 ? FACES.count - 1 : @current_index - 1
  end

end