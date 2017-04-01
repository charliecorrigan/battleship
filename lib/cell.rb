class Cell
  attr_accessor :ship, :fired_on, :turn_result, :up, :down, :left, :right
  
  def initialize
    @ship = false
    @fired_on = false
    @turn_result = nil
    @up = nil
    @down = nil
    @left = nil
    @right = nil
  end
end