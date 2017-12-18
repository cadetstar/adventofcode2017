#!/usr/bin/env ruby

stepnum = 3
stepnum = 363
arr = []

total = 0
50_000_000.times do |i|
  total += stepnum
  if i > 0
    total %= i
  else
    total = 0
  end
  total += 1
  #puts [i, total].inspect

  if total == 1
    puts i
  end
end

