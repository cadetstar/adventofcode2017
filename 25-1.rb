#!/usr/bin/env ruby

require 'yaml'
require 'byebug'
require 'awesome_print'

input = File.readlines('25.txt').map(&:chomp)

state = 'A'
checksum = (input[1].match(/ (\d+) /))[1].to_i

puts checksum

yaml = YAML.load(input[3..-1].join(10.chr))
puts yaml.inspect

states = {}

yaml.keys.each do |k|
	s = k.match(/ (.)$/)[1]
  states[s] = {}
  yaml[k].keys.each do |j|
    t = j.match(/ (\d)$/)[1].to_i
    states[s][t] = []

    states[s][t] = yaml[k][j]
  end
end

registers = {}
cursor = 0
i = 0
while i < checksum
  registers[cursor] ||= 0
  states[state][registers[cursor]].each do |cmd|
    case cmd
    when /^Write the value (\d)\.$/
      registers[cursor] = $1.to_i
    when /Move one slot to the right\./
      cursor += 1
    when /Move one slot to the left\./
      cursor -= 1
    when /Continue with state (.)\.$/
      state = $1
    else
      puts "Unknown command: #{cmd}"
      break
    end
  end
  i += 1
  if i % 100000 == 0
    puts i
  end
end
puts registers.values.reduce(:+)
