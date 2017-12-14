#!/usr/bin/env ruby

text = File.readlines('13.txt').map(&:chomp)

layers = {}
text.each do |line|
  num, range = *line.split(/: /)
  layers[num.to_i] = range.to_i
end


offset = 0
loop do
  offset += 1
  puts "Trying #{offset}"
  triggers = []
  (layers.keys.min..layers.keys.max).each do |i|
    next unless layers[i]
    if (i + offset) % ((layers[i] - 1) * 2) == 0
      triggers << i
      break
    end
  end
  break if triggers.size == 0
end

puts offset
