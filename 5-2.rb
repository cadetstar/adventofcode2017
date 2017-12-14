#!/usr/bin/env ruby

steps = File.readlines('5.txt').map(&:to_i)

puts steps.inspect


cur_step = 0
step_count = 0
max_step = 0

until cur_step < 0 or cur_step >= steps.size
  new_step = cur_step + steps[cur_step]
  if steps[cur_step] >= 3
    steps[cur_step] -= 1
  else
    steps[cur_step] += 1
  end
  step_count += 1
  cur_step = new_step
  if new_step > max_step
    max_step = new_step
    puts ''
    puts max_step
  end
end

puts "Total: #{step_count}"
