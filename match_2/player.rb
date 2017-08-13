class Player

  attr_reader :name

  def initialize(name)
    @name == name
  end

end

class HumanPlayer < Player

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
    input.map(&:to_i)
  end

  def valid_move?(pos)
    pos.all? { |el| ('0'...'4').cover?(el) }
  end
end

class CompPlayer < Player
  
end
