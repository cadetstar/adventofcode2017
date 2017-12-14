#!/usr/bin/env ruby

phrases = File.readlines('4.txt').map(&:chomp)

valids = phrases.select do |r|
  elems = r.split(/ /).map{|w| w.split(//).sort.join}
  puts elems.inspect
  elems.size == elems.uniq.size
end

puts valids.count
