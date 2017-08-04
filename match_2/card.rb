# require "byebug"
class Card

  attr_accessor :value, :face_down

  def initialize(value)
    @value = value
    @face_down = true
  end

  def face_down
    @face_down
  end

  def hide
    @face_down = true
  end

  def reveal
    @face_down = false
  end

  def to_s
    if @face_down
      "*"
    else
      @value.to_s
    end
  end

  def ==(other_card)
    @value == other_card.value
  end

end
