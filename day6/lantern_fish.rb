require "pry"

class LaternFish
  attr_reader :fish_pool
  def initialize(file_name)
    @fish_pool = File.open(file_name).read.split(',').map(&:to_i)
  end
  
  def day_passes
    new_fish = 0
    fish_pool.each_with_index do |fish_timer, index|
      case fish_timer
      when 0
        new_fish += 1
        fish_pool[index] = 6
      else
        fish_pool[index] -= 1
      end
    end
    new_fish.times{ fish_pool << 8}
  end
  
  def num_fish
    fish_pool.size
  end
  
  def num_day_passes(num)
    begin
      num.times { day_passes }
    rescue NoMemoryError
      puts fish_pool.size
      binding.pry
    end
  end
end

txt1 = "day6_sample.txt"
txt2 = "day6.txt"
txt3 = "scratch.txt"

lanterns = LaternFish.new(txt1)
lanterns.num_day_passes(80)
p lanterns.num_fish
# 81.times do |day|
#   puts "#{day}, #{lanterns.num_fish}"
#   lanterns.day_passes
# end