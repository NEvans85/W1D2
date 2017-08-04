require_relative 'tile'

class Board

  SORTED_SET = [1, 2, 3, 4, 5, 6, 7, 8, 9].freeze

  def initialize
    @grid = Array.new(9) { [] }
    populate_grid('sudoku1-almost.txt')
  end

  def populate_grid(filename)
    file_input = File.readlines(filename)
    file_input.each_with_index do |line, l_idx|
      line = line.chomp
      line.each_char do |chr|
        is_fixed = !chr.to_i.zero?
        @grid[l_idx] << Tile.new(chr.to_i, is_fixed)
      end
    end
  end

  def render
    @grid.each_with_index do |row, idx|
      print idx
      row.each do |tile|
        print "| #{tile} "
      end
      print "|\n"
    end
  end

  def play_move(pos, new_value)
    @grid[pos[0]][pos[1]].value = new_value
  end

  def won?
    won = true
    (0..8).each do |idx|
      won = false if complete_set?(row(idx))
      won = false if complete_set?(column(idx))
      won = false if complete_set?(sectors[idx])
    end
    won
  end

  def complete_set?(arr)
    arr.map { |pos| self[pos].value }.sort != SORTED_SET
  end

  def fixed?(pos)
    @grid[pos[0]][pos[1]].fixed?
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @grid[pos[0]][pos[1]].value = value
  end

  def full?
    @grid.flatten.none? { |tile| tile.value.zero? }
  end

  def row_values(idx)
    self[@grid[idx]].value
  end

  def column_values(idx)
    column = []
    @grid.each { |row| column << self[row[idx]].value }
    column
  end

  def sectors
    [[[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]],
     [[0, 3], [0, 4], [0, 5], [1, 3], [1, 4], [1, 5], [2, 3], [2, 4], [2, 5]],
     [[0, 6], [0, 7], [0, 8], [1, 6], [1, 7], [1, 8], [2, 6], [2, 7], [2, 8]],
     [[3, 0], [3, 1], [3, 2], [4, 0], [4, 1], [4, 2], [5, 0], [5, 1], [5, 2]],
     [[3, 3], [3, 4], [3, 5], [4, 3], [4, 4], [4, 5], [5, 3], [5, 4], [5, 5]],
     [[3, 6], [3, 7], [3, 8], [4, 6], [4, 7], [4, 8], [5, 6], [5, 7], [5, 8]],
     [[6, 0], [6, 1], [6, 2], [7, 0], [7, 1], [7, 2], [8, 0], [8, 1], [8, 2]],
     [[6, 3], [6, 4], [6, 5], [7, 3], [7, 4], [7, 5], [8, 3], [8, 4], [8, 5]],
     [[6, 6], [6, 7], [6, 8], [7, 6], [7, 7], [7, 8], [8, 6], [8, 7], [8, 8]]]
  end

  # def sector(pos)
  #   sector = []
  #   case pos[0]
  #   when (0..2).cover?
  #     sector = @grid[0..2]
  #   when (3..5).cover?
  #     sector = @grid[3..5]
  #   when (6..8).cover?
  #     sector = @grid[6..8]
  #   end
  #   case pos[1]
  #   when (0..2).cover?
  #     sector.map! { |row| row.slice(0, 3) }
  #   when (3..5).cover?
  #     sector.map! { |row| row.slice(3, 3) }
  #   when (6..8).cover?
  #     sector.map! { |row| row.slice(6, 3) }
  #   end
  #   sector.flatten
  # end
end
