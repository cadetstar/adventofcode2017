#!/usr/bin/env ruby

input = File.readlines('19.txt').map(&:chomp)

sample_data = <<-TEXT
     |
     |  +--+
     A  |  C
 F---|--|-E---+
     |  |  |  D
     +B-+  +--+
                          ..
TEXT
#input = sample_data.split(/\n/)

pos = [0,0]
dir = 'd'
found_letters = []
count = 0

pos[1] = input[0].index('|')

turn_data = {
  'd' => { turn: %w(r l), adder: [1,0] },
  'u' => { turn: %w(l r), adder: [-1,0] },
  'r' => { turn: %w(u d), adder: [0,1] },
  'l' => { turn: %w(d u), adder: [0,-1] }
}
require 'byebug'

loop do
  modifier = turn_data[dir][:adder]
  new_pos = [pos[0] + modifier[0], pos[1] + modifier[1]]
  puts new_pos.inspect
  test_value = input[new_pos[0]][new_pos[1]]
  break if pos[0] < 0
  break if pos[0] > input.size
  break if pos[1] < 0
  break if pos[1] > input.map(&:size).max + 50

  count += 1

  if test_value == ' ' || test_value.nil?
    dir = turn_data[dir][:turn].select do |s|
      new_val = input[pos[0] + turn_data[s][:adder][0]][pos[1] + turn_data[s][:adder][1]]
      new_val && new_val != ' '
    end.first
    if dir
      count -= 1
      next
    else
      puts "Found the end: #{pos.inspect}"
      break
    end
  else
    if test_value =~ /[A-Z]/
      found_letters << test_value
    end
    pos = new_pos
  end
end

puts count
puts found_letters.inspect
puts found_letters.join
