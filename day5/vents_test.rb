require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
require_relative 'vents'

class VentTest < Minitest::Test
  attr_reader :sea_bed
  def setup
    @sea_bed = Vents.new("day5_sample.txt")
  end
  
  def test_vertical?
    assert_equal(true, sea_bed.vertical?([[0, 9], [0, 5]]))
    assert_equal(false, sea_bed.vertical?([[0, 9], [5, 9]]))
  end
  
  def test_horizontal?
    assert_equal(true, sea_bed.horizontal?([[9, 0], [5, 0]]))
    assert_equal(false, sea_bed.horizontal?([[9, 0], [5, 1]]))
  end
  
  def test_start_end_vents
    assert_equal([[0, 9], [5, 9]], sea_bed.start_end("0,9 -> 5,9"))
  end
  
  def test_mark_vents
    sea_bed.mark_vents
    assert_equal({[0, 9]=>2, [1, 9]=>2, [2, 9]=>2, [3, 9]=>1, [4, 9]=>1, [5, 9]=>1, [0, 8]=>1, [1, 7]=>1, [2, 6]=>1, [3, 5]=>1, [4, 4]=>3, [5, 3]=>2, [6, 2]=>1, [7, 1]=>2, [8, 0]=>1, [3, 4]=>2, [5, 4]=>1, [6, 4]=>3, [7, 4]=>2, [8, 4]=>1, [9, 4]=>1, [2, 1]=>1, [2, 2]=>2, [7, 0]=>1, [7, 2]=>1, [7, 3]=>2, [2, 0]=>1, [3, 1]=>1, [4, 2]=>1, [1, 4]=>1, [2, 4]=>1, [0, 0]=>1, [1, 1]=>1, [3, 3]=>1, [5, 5]=>2, [6, 6]=>1, [7, 7]=>1, [8, 8]=>1, [8, 2]=>1}, sea_bed.grid)
  end
  
  def test_mark_vent
    sea_bed.mark_vent( [[2,1],[2,2]])
    assert_equal({[2,1] => 1, [2,2] => 1}, sea_bed.grid)
    sea_bed.mark_vent( [[4,2], [1,2]])
    assert_equal({[2,1] => 1, [2,2] => 2, [1,2] => 1, [3,2] => 1, [4,2] => 1}, sea_bed.grid)
  end
  
  def test_mark_vent2
    sea_bed.mark_vent([[8,0], [0,8]])
    assert_equal({[0,8] => 1, [1,7] => 1, [2,6] => 1, [3,5] => 1, [4,4] => 1, [5,3] => 1, [6,2] => 1, [7,1] => 1, [8,0] => 1}, sea_bed.grid)
  end
  
  def test_mark_point
    sea_bed.mark_point([0, 9])
    assert_equal({ [0, 9] => 1 }, sea_bed.grid)
    sea_bed.mark_point([0, 9])
    assert_equal({ [0, 9] => 2 }, sea_bed.grid)
  end
  
  def test_count_points
    sea_bed.mark_vents
    assert_equal(12, sea_bed.count_points)
  end
  
  # def test_full_run
  #   sea_bed.mark_vents
  #   p sea_bed.count_points
  # end
end