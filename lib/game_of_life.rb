

class GameOfLife
  attr_reader :raw

  def initialize
  end

  def alive?(row, col)
    neighbours = 0
    [
      [row - 1, col - 1], [row - 1, col], [row - 1, col + 1],
      [row    , col - 1],                 [row    , col + 1],
      [row + 1, col - 1], [row + 1, col], [row + 1, col + 1]
    ].each do |r, c|
      neighbours += 1 if @raw[[r, c]]
    end

    if neighbours < 2
      false
    elsif @raw[[row, col]]
      if neighbours == 2 or neighbours == 3
        true
      else
        false
      end
    elsif neighbours == 3
      true
    else
      false
    end
  end

  def draw(window)
    @raw.keys.each do |k|
      window.move *k
      window.addstr("X")
    end
  end

  def step
    coordinates = @raw.keys.sort
    new_raw = Hash.new
    # Coordinates are now listed in order of row then column
    min_row, min_col = coordinates.first
    max_row, max_col = coordinates.last
    # Evaluate the life or death of every cell within the used area of the
    # field, including the border around the are which may spring into life.
    ((min_row - 1)..(max_row + 1)).each do |row|
      ((min_col - 1)..(max_col + 1)).each do |col|
        if alive?(row, col)
          new_raw[[row, col]] = true
        end
      end
    end
    @raw = new_raw
    self
  end
end
