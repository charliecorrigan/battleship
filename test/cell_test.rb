require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'

class TestCell < Minitest::Test

  def test_new_instance_initialize_values
    cell = Cell.new("a1")
    assert_equal "a1", cell.name
    refute cell.ship
    refute cell.fired_on
    assert_nil cell.turn_result
    assert_nil cell.up
    assert_nil cell.down
    assert_nil cell.left
    assert_nil cell.right
  end

  def test_attributes_can_be_changed
    cell = Cell.new("a1")
    cell.ship = true
    cell.fired_on = true
    cell.turn_result = "hit"
    assert cell.ship
    assert cell.fired_on
    assert_equal "hit", cell.turn_result
  end
end