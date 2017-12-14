#!/usr/bin/env ruby

steps = File.readlines('5.txt').map(&:to_i)

puts steps.inspect


cur_step = 0
step_count = 0

until cur_step < 0 or cur_step >= steps.size
  new_step = cur_step + steps[cur_step]
  steps[cur_step] += 1
  step_count += 1
  cur_step = new_step
  print "#{new_step},"
end

puts "Total: #{step_count}"
