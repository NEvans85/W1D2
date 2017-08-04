require 'colorize'

class Tile

  attr_reader :bool_fixed
  attr_accessor :value

  def initialize(value, bool_fixed)
    @value = value
    @bool_fixed = bool_fixed
  end

  def to_s
    return @value.to_s.colorize(:red) if @bool_fixed
    return '_' if @value.zero?
    @value.to_s.colorize(:blue)
  end

  def fixed?
    @bool_fixed
  end
  
end
