file = File.open("day4.txt")
report = file.read
readings = report.split(/\n\n/)

numbers = readings[0]
boards = readings[1..-1]
p boards[0].split(/[\s]+/)

class Square
  def initialize(number)
    @number = number
    @marked = false
  end
  
  def marked?
    marked
  end
  
  def mark
    self.marked = true
  end
  
  private
  attr_reader :number
  attr_accessor :marked
end
