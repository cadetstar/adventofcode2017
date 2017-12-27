#!/usr/bin/env ruby

require 'byebug'

input = File.readlines('24.txt').map(&:chomp)

elems = input.map{|i| i.split('/').map(&:to_i) }

$max = 0

def choose_next(conn, elems, chain = [])
  candidates = elems.select{|e| e[0] == conn || e[1] == conn}
  if candidates.empty?
    strength = chain.flatten.reduce(:+)
    if strength > $max
      $max = strength
      puts $max
    end
  else
    candidates.each do |c|
      new_conn = c[0] == conn ? c[1] : c[0]
      choose_next(new_conn, elems - [c], chain + [c])
    end
  end
end

choose_next(0, elems)

