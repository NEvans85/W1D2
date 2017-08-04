require_relative 'board'
require 'byebug'

class Game

  def initialize(board)
    @board = board
  end

  def get_move
    valid = false
    until valid
      puts "Enter row: "
      row = gets.chomp
      puts "Enter column:"
      col = gets.chomp
      puts 'What number?'
      val = gets.chomp
      valid = valid_move?([row.to_i, col.to_i], val.to_i)
      puts 'Invlaid move' unless valid
    end
    [[row.to_i, col.to_i], val.to_i]
  end

  def valid_move?(pos, new_value)
    valid = true
    pos.each { |el| valid = false if (0..8).cover?(el) }
    valid = false unless (1..9).cover?(new_value)
    valid = false if @board.fixed?(pos)
    valid
  end

  def play_turn
    @board.render
    @board.play_move(*get_move)
  end

  def play
    play_turn until game_over?
    puts 'You Win!'
  end

  def game_over?
    return @board.won? if @board.full?
    false
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new(Board.new).play
end
