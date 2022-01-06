=begin
problem determine whether 0 or 1 is most common at each index value
gamma rate << most common
epsilon << least common
power consumption = epsilon.to_digit * gamma_rate.to_digit

input list of binary numbers
output integer

constraints
  explicit
    gamma comes from most common bits
    epsilon comes from least common bits
    power consumption is multiple of both
  implicit
    diagnositc report contains binary numbers without a specified length
    
edge? what if they have an equal amount?

gamma = []
epsilon = []
iterate through each position
  freq = determine whether 0 or 1 occurs more?
  epsilon << freq
  if freq == 1 ? epsilon << 0 : epsilon << 1
combine arrays into strings
convert epsilon and gamma to integers
multiply
=end

require "pry"
file = File.open("day3.txt")
report = file.read
readings = report.split
total = readings.size
gamma = ""
epsilon = ""
readings[0].chars.each_with_index do |_,index|
  ones  = readings.count {|reading| reading[index] == "1"}
  if ones/total.to_f > 0.5
    gamma << "1"
    epsilon << "0"
  else
    gamma << "0"
    epsilon << "1"
  end
end
p gamma.to_i(2)
p epsilon.to_i(2)
p gamma.to_i(2) * epsilon.to_i(2)

=begin
determine the most common bit at each posistion
keep/discard those values. If there is a tie keep either 1 or 0 in that posisition

keep only numbers that fit the search criteria
when only have one number left, stop, that is the rating value
repeat the process until only one number left.

02_gen_rating
new_array = readings
iterate through first string split into chars with index
  determine most common bit
    if both bits are equal set most common bit to 1
  new_array = select all values in new_array that have that bit at that index
  return new_array if only one value
    converted to string
    converted to integer

co2_scrubber
new_array = readings
iterate through first string split into chars with index
  determine most common bit
    if both bits are equal set most common bit to 1
  set least common to opposite of most common
  new_array = select all values in new_array that have that have the least common bit at that index
  return new_array if only one value
    converted to string
    converted to integer

=end

def most_common(array,index)
  ones  = array.count {|item| item[index] == "1"}
  ones/array.size.to_f >= 0.5 ? '1' : '0'
end

# o2_gen_rating
new_array = readings
o2_gen_rating = nil
readings[0].chars.each_with_index do |_, index|
  common = most_common(new_array, index)
  new_array = new_array.select{|item| item[index] == common}
  if new_array.size == 1
    o2_gen_rating = new_array.join
    break
  end
end
p o2_gen_rating

new_array = readings
co2_scrubber = nil
readings[0].chars.each_with_index do |_, index|
  common = most_common(new_array, index)
  least = (common == "1" ? "0" : "1")
  new_array = new_array.select{|item| item[index] == least}
  if new_array.size == 1
    co2_scrubber = new_array.join
    break
  end
end
p co2_scrubber
p o2_gen_rating.to_i(2) * co2_scrubber.to_i(2)