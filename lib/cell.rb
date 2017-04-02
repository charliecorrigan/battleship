class Cell
  attr_accessor :name, :ship, :fired_on, :turn_result, :up, :down, :left, :right
  
  def initialize(name)
    @name = name
    @ship = false
    @fired_on = false
    @turn_result = nil
    @up = nil
    @down = nil
    @left = nil
    @right = nil
  end
end