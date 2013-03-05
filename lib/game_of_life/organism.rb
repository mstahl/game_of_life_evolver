module GameOfLife
  class Organism
    attr_reader :raw
    attr_reader :history

    def initialize(raw = nil)
      @history = []
      @raw = raw || {}
    end

    # Instance methods ========================================================

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

    def center
      [(max_row + min_row)/2, (max_col + min_col)/2]
    end

    def draw(window)
      @raw.keys.each do |k|
        window.move *k
        window.addstr("X")
      end
    end

    def min_row
      @raw.keys.map(&:first).sort.first
    end

    def max_row
      @raw.keys.map(&:first).sort.last
    end

    def min_col
      @raw.keys.map(&:last).sort.first
    end

    def max_col
      @raw.keys.map(&:last).sort.last
    end

    def step
      coordinates = @raw.keys
      new_raw = Hash.new

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

    def translate!(dx, dy)
      @raw = @raw.keys.inject({}) {|h, c| h[[c[0] + dx, c[1] + dy]] = true; h}
      self
    end

    # Class methods ===========================================================

    def self.from_string(string)
      coordinates = {}
      string.lines.each_with_index do |line, row|
        line.split(//).each_with_index do |character, col|
          coordinates[[row, col]] = true if character == 'X'
        end
      end
      # Adjust coordinates to be centred around the origin
      organism = Organism.new(coordinates)
      translate_x, translate_y = organism.center
      organism.translate!(-translate_x, -translate_y)
    end

  end
end
