require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'


class TestCell < Minitest::Test

  def test_new_instance_initialize_values
    cell = Cell.new
    refute cell.ship?
    refute cell.fired_on?
    assert_nil cell.turn_result
    assert_nil cell.up
    assert_nil cell.down
    assert_nil cell.left
    assert_nil cell.right
  end
end