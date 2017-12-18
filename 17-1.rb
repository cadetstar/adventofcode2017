#!/usr/bin/env ruby

stepnum = 3
stepnum = 363
arr = []
2018.times do |i|
  arr.rotate!(stepnum + 1)
  arr.unshift i
  j = arr.index(0)
  puts arr[j,3].inspect
end


total = 0
2018.times do |i|
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

