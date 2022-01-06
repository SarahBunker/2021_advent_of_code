require "pry"

class Vents
  attr_accessor :list, :vents, :grid
  def initialize(datafile)
    @list = File.open(datafile).read
    @vents = list.split(/\n/)
    @grid = Hash.new(0)
  end
  
  def start_end(vent)
    points = vent.split
    [points[0].split(',').map(&:to_i), points[-1].split(',').map(&:to_i)]
  end
  
  def vertical?(point_pair)
    point_pair[0][0] == point_pair[1][0]
  end
  
  def horizontal?(point_pair)
    point_pair[0][1] == point_pair[1][1]
  end
  
  def mark_vents
    vents.each do |vent|
      point_pair = start_end(vent)
      mark_vent(point_pair)
    end
  end
  
  def mark_vent(point_pair)
    if vertical?(point_pair)
      x = point_pair[0][0]
      y1 = point_pair[0][1]
      y2 = point_pair[1][1]
      y1, y2 = [y1, y2].sort
      (y1..y2).to_a.each do |y|
        mark_point([x,y])
      end
    elsif horizontal?(point_pair)
      y = point_pair[0][1]
      x1 = point_pair[0][0]
      x2 = point_pair[1][0]
      x1, x2 = [x1, x2].sort
      (x1..x2).to_a.each do |x|
        mark_point([x,y])
      end
    else
      point_pair = point_pair.sort_by{|x, _| x}
      y = point_pair[0][1]
      ascending = y < point_pair[1][1]
      x1 = point_pair[0][0]
      x2 = point_pair[1][0]
      x1, x2 = [x1, x2].sort
      (x1..x2).to_a.each do |x|
        mark_point([x,y])
        ascending ? y += 1 : y -= 1
      end
    end
  end
  
  def mark_point(pair)
    grid[pair] += 1
  end
  
  def count_points
    grid.select {|key, value| value >= 2}.size
  end
end

txt1 = "day5_sample.txt"
txt2 = "day5.txt"

sea_bed = Vents.new(txt2)
sea_bed.mark_vents
# p sea_bed.grid
p sea_bed.count_points