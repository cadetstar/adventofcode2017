#!/usr/bin/env ruby

inputs = File.read('16.txt').chomp
dirs = inputs.split(/,/)

arr = ('a'..'p').to_a

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

puts arr.inspect
puts arr.join
