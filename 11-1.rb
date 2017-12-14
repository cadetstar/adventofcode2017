#!/usr/bin/env ruby

text = File.read('11.txt').chomp

dirs = text.split(/,/)

posV = 0
posU = 0
posD = 0

max_steps = 0

dirs.each do |d|
  case d
  when 'n'
    posU += 1
    posD += 1
  when 'ne'
    posD += 1
    posV += 1
  when 'se'
    posU -= 1
    posV += 1
  when 'sw'
    posD -= 1
    posV -= 1
  when 'nw'
    posU += 1
    posV -= 1
  when 's'
    posU -= 1
    posD -= 1
  end
  absolutes = [posV.abs, posU.abs, posD.abs]
  new_max = absolutes.combination(2).map{|c| c.reduce(:+)}.min
  if new_max > max_steps
    max_steps = new_max
  end
end

puts [posV, posU, posD].inspect

puts max_steps
# Now, "raycast" along each six directions
# Go V, then U
# Go V, then D
# Go U, then D
