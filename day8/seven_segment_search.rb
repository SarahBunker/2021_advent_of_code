txt1 = "day8.txt"
txt2 = "day8_sample.txt"
displays = File.open(txt1).read.split(/\n/)
output_displays = displays.map {|display| display.split(" | ")[1]}
count = 0
UNI_LEN = [2,4,3,7]
output_displays.each do |o_display|
  o_display.split.each do |o_digit|
    if UNI_LEN.include? (o_digit.size)
      count += 1
    end
  end
end
p count

require "pry"

class SevenSegmentSearch
  attr_reader :displays, :output_values
  
  def initialize(txt)
    @displays = File.open(txt).read.split(/\n/)
    @output_values = []
  end
  
  def find_sum_outputs
    decode_display(displays[0])
  #   displays.each do
      
  #   end
  end
  
  def decode_display(display)
    letters = "abcdefg"
    patterns, digits = display.split(" | ")
    patterns = patterns.split
    digits = digits.split
    # decoder = CodedNumbers.new(patterns, digits)
    
  end
end

testing = SevenSegmentSearch.new(txt2)
testing.find_sum_outputs

class CodedNumbers
  attr_reader :patterns, :digits, :cf, :a, :bd, :eg, :number_hash
  def initialize(patterns, digits)
    @patterns = patterns
    @digits = digits
    @number_hash = {}
  end
  
  def decoded_number
    determine_segments
    determine_numbers
    number_string = ""
    digits.each do |digit_string|
      p number_hash
      p digit_string.chars.sort.join
      p number_hash[digit_string.chars.sort.join]
      number_string << number_hash[digit_string.chars.sort.join]
    end
    number_string.to_i
  end
  
  def determine_segments
    c_f_segment
    a_segment
    b_d_segment
    e_g_segment
  end
  
  def determine_numbers
    zero
    one
    two
    three
    four
    five
    six
    seven
    eight
    nine
  end
  
  def join_segments(array)
    array.map(&:string).join.chars.sort.join
  end
  
  def zero
    NumberSegments
    number_hash[ [a, bd, cf, eg, cf, eg] ] = "0"
  end
  
  def one
    number_hash[ j[cf, cf]] = "1"
  end
  
  def two
    number_hash[ [a, cf, bd, eg, eg]] = "2"
  end
  
  def three
    number_hash[ [a, cf, bd, cf, eg]] = "3"
  end
  
  def four
    number_hash[ [bd, cf, bd, cf]] = "4"
  end
  
  def five
    number_hash[ join_segments([a, bd, bd, cf, eg])] = "5"
  end
  
  def six
    number_hash[ join_segments([a, bd, bd, eg, cf, eg])] = "6"
  end
  
  def seven
    number_hash[ join_segments([a, cf, cf])] = "7"
  end
  
  def eight
    number_hash[ join_segments([a, bd, cf, bd, eg, cf, eg])] = "8"
  end
  
  def nine
    number_hash[ join_segments([a, bd, cf, bd, cf, eg])] = "9"
  end
  
  def c_f_segment
    cf_string = patterns.select {|pattern| pattern.size == 2}[0]
    @cf = Segment.new(cf_string)
  end
  
  def a_segment
    a_string = patterns.select {|pattern| pattern.size == 3}[0].delete(cf.string)
    @a  = Segment.new(a_string)
  end
  
  def b_d_segment
    b_d_string = patterns.select {|pattern| pattern.size == 4}[0].delete(cf.string)
    @bd  = Segment.new(b_d_string)
  end
  
  def e_g_segment
    e_g_string = "abcdefg".delete(a.string).delete(cf.string).delete(bd.string)
    @eg = Segment.new(e_g_string)
  end
end

class Segment
  attr_reader :letters
  def initialize(letters)
    @letters = letters
  end
  
  # def ==(letter)
  #   letters.include?(letter)
  # end
  
  def string
    letters.dup
  end
  
  def <=>(other)
    string <=> other.string
  end
end

class NumberSegments
  def initialize(segments, digit)
    @digit = digit
    @segments = segments
  end
  
  def ==(other)
    segments == other.segments
  end
  
  def segments
    @segments.sort
  end
end

decoder = CodedNumbers.new(["be", "cfbegad", "cbdgef", "fgaecd", "cgeb", "fdcge", "agebfd", "fecdb", "fabcd", "edb"], ["fdgacbe", "cefdb", "cefbgd", "gcbe"])
decoder.c_f_segment
decoder.a_segment
decoder.b_d_segment
decoder.e_g_segment
# p decoder.a.string
# p decoder.cf.string
# p decoder.bd.string
# p decoder.eg.string
p decoder.decoded_number