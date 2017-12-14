#!/usr/bin/env ruby

text = File.readlines('13.txt').map(&:chomp)

layers = {}
text.each do |line|
  num, range = *line.split(/: /)
  layers[num.to_i] = range.to_i
end

triggers = []
offset = 0

(layers.keys.min..layers.keys.max).each do |i|
  next unless layers[i]
  if (i + offset) % ((layers[i] - 1) * 2) == 0
    triggers << i
  end
end

puts triggers.inspect

puts triggers.map{|i| layers[i] * i}.reduce(:+)
