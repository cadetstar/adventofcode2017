#!/usr/bin/env ruby

require 'set'

startA = 512
startB = 191

multA = 16807
multB = 48271

goto = 40_000_000
#goto = 5

mod = 2147483647

total_matches = Set.new

modvalA = startA
modvalB = startB

(1..goto).each do |iter|
  modvalA = (modvalA * multA) % mod
  modvalB = (modvalB * multB) % mod
  binA = '%16b' % modvalA
  binB = '%16b' % modvalB
  if binA[-16..-1] == binB[-16..-1]
#    puts "MATCH!"
    total_matches << iter
  end
#  puts [iter, modvalA, modvalB].inspect
#  puts [iter, binA, binB].inspect
  if iter % 100000 == 0
    puts iter
  end
end

puts total_matches.size
require 'awesome_print'
ap total_matches
