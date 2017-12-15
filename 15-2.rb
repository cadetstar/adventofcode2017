#!/usr/bin/env ruby

require 'set'

startA = 512
startB = 191

multA = 16807
multB = 48271

goto = 5_000_000
#goto = 5

mod = 2147483647

total_matches = Set.new

modvalA = startA
modvalB = startB

checkmodA = 4
checkmodB = 8

(1..goto).each do |iter|
  modvalA = (modvalA * multA) % mod
  until modvalA % checkmodA == 0
    modvalA = (modvalA * multA) % mod
  end
  modvalB = (modvalB * multB) % mod
  until modvalB % checkmodB == 0
    modvalB = (modvalB * multB) % mod
  end
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
