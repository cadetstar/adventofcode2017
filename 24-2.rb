#!/usr/bin/env ruby

require 'byebug'

input = File.readlines('24.txt').map(&:chomp)

elems = input.map{|i| i.split('/').map(&:to_i) }

$max_length = 0
$max_strength = 0

def choose_next(conn, elems, chain = [])
  candidates = elems.select{|e| e[0] == conn || e[1] == conn}
  if candidates.empty?
    l = chain.length
    if l > $max_length
      $max_length = l
      $max_strength = chain.flatten.reduce(:+)
      puts [$max_length, $max_strength].inspect
    elsif l == $max_length
      strength = chain.flatten.reduce(:+)
      if strength > $max_strength
        $max_strength = strength
        puts [$max_length, $max_strength].inspect
      end
    end
  else
    candidates.each do |c|
      new_conn = c[0] == conn ? c[1] : c[0]
      choose_next(new_conn, elems - [c], chain + [c])
    end
  end
end

choose_next(0, elems)

