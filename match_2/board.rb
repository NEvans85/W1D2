require_relative 'card'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(4) { Array.new(4) }
  end

  def reveal(pos)
    @grid[pos[0]][pos[1]].reveal
  end

  def render
    @grid.each do | row |
      row.each do | card |

        print "| #{card} "
      end

      print "|\n"
    end
  end

  def populate
    nums =[1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8].shuffle
    @grid.each do | row |
      row.each_index { | idx | row[idx] = Card.new(nums.pop) }
    end
  end

  def hide(pos)
    @grid[pos[0]][pos[1]].hide
  end

  def won?
    @grid.each do |row|
      return false if row.any?(&:face_down)
    end
    true
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end


end
