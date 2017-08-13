require_relative 'card'
require_relative 'board'
require_relative 'player'


class Game

  attr_reader :board
  def initialize(board)
    @board = board
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
