file = File.open("day1.txt")
text = file.read
readings = text.split.map(&:to_i)
triple_readings = []
readings.each_cons(3) {|a| triple_readings << a.sum}
num_depth_increase = 0
previous_measurement = nil
triple_readings.each do |measurement|
  if previous_measurement && previous_measurement < measurement
    num_depth_increase += 1
  end
  previous_measurement = measurement
end
# p triple_readings
puts num_depth_increase

# 199
# 200
# 208
# 210
# 200
# 207
# 240
# 269
# 260
# 263