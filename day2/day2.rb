require "pry"
file = File.open("day2.txt")
text = file.read
directions = text.split(/\n/).map(&:split)

class Submarine
  attr_accessor :horizontal, :depth, :aim
  
  def initialize
    @horizontal = 0
    @depth = 0
    @aim = 0
  end
  
  def forward(num)
    self.horizontal += num
    self.depth += aim*num
  end
  
  def down(num)
    self.aim += num
  end
  
  def up(num)
    self.aim -= num
  end
  
  def follow_course(course)
    course.each do |movement, amount|
      send(movement, amount.to_i)
    end
  end
end

jingle = Submarine.new
jingle.follow_course(directions)
# jingle.forward(5)
# jingle.down(5)
# jingle.forward(8)
# jingle.up(3)
# jingle.down(8)
# jingle.forward(2)
p jingle.horizontal
p jingle.depth
puts
p jingle.horizontal * jingle.depth