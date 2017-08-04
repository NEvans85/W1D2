require_relative 'card'
require_relative 'board'

class Game

  attr_reader :board
  def initialize(board)
    @board = board
  end

  def get_move
    valid = false
    until valid
      input = []
      puts 'Which row?'
      input << gets.chomp
      puts 'Which column?'
      input << gets.chomp
      valid = valid_move?(input)
      puts 'Invalid move' unless valid
    end
    numberfy_input(input)
  end

  def numberfy_input(input_pos)
    input_pos.map(&:to_i)
  end

  def valid_move?(pos)
    pos.all? { |el| ('0'...'4').cover?(el) }
  end

  def take_turn
    system("clear")
    @board.render
    move1 = get_move
    @board.reveal(move1)
    @board.render
    move2 = get_move
    @board.reveal(move2)
    @board.render
    unless @board[move1] == @board[move2]
      @board.hide(move1)
      @board.hide(move2)
    end
    sleep(2)
  end



  def play
    @board.populate
    take_turn until @board.won?
    puts 'You Win!'
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.new(Board.new).play

end
