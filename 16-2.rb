#!/usr/bin/env ruby

inputs = File.read('16.txt').chomp
dirs = inputs.split(/,/)

arr = ('a'..'p').to_a

seen = {}
max = 1_000_000_000
(1..max).each do |i|
  dirs.each do |dir|
    case dir
    when /^s(\d+)$/
      arr.rotate!(-1 * $1.to_i)
    when /^x(\d+)\/(\d+)$/
      f = arr[$1.to_i]
      b = arr[$2.to_i]
      arr[$1.to_i] = b
      arr[$2.to_i] = f
    when /^p(.)\/(.)$/
      fi = arr.index($1)
      bi = arr.index($2)
      arr[fi] = $2
      arr[bi] = $1
    end
  end
  if seen[arr.join]
    puts "Currently: #{i}. Saw previously at #{seen[arr.join]}"
    break
  else
    seen[arr.join] = i
  end
end

puts arr.inspect
puts arr.join
puts seen.invert[max % 42]
