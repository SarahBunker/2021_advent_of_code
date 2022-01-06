require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
require_relative 'lantern_fish'

class LaternFishTest < Minitest::Test
  attr_reader :lantern
  def setup
    @lantern = LaternFish.new("day6_sample.txt")
  end
  
  def test_setup
    assert_equal([3, 4, 3, 1, 2], lantern.fish_pool)
  end
  
  def test_day_passes
    lantern.day_passes
    assert_equal([2, 3, 2, 0, 1], lantern.fish_pool)
    lantern.day_passes
    assert_equal([1, 2, 1, 6, 0, 8], lantern.fish_pool)
  end
  
  def test_num_fishes
    assert_equal(5, lantern.num_fish)
    lantern.day_passes
    lantern.day_passes
    assert_equal(6, lantern.num_fish)
  end
  
  def test_num_fishes_over_more_days
    18.times {lantern.day_passes}
    assert_equal(26, lantern.num_fish)
  end
  
  def test_num_fishes_over_80_days
    80.times {lantern.day_passes}
    assert_equal(5934, lantern.num_fish)
  end
  
  def test_num_day_passes
    lantern.num_day_passes(80)
    assert_equal(5934, lantern.num_fish)
  end
  
  def test_num_day_passes_256
    skip
    lantern.num_day_passes(256)
    assert_equal(26984457539, lantern.num_fish)
  end
end