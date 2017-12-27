#!/usr/bin/env ruby
require 'awesome_print'

# between 908 and 1000

input = File.readlines('23.txt').map(&:chomp)

registers = {'a' => 1}
current = 0

iter = 0

while current >= 0 and current < input.size
  iter += 1
  if (iter % 10000) == 0
    puts current
    ap registers
  end
  case input[current]
  when /^jnz (.) (.+)$/
    check = $1
    step_det = $2
    step = if step_det.to_i.to_s == step_det
             step_det.to_i
           else
             registers[step_det] ||= 0
           end

    if check.to_i.to_s == check
      if check.to_i != 0
        current += step
        next
      end
    else
      if (registers[check] || 0) != 0
        current += step
        next
      end
    end
  when /^(set|sub|mul) (.) (.+)$/
    cmd = $1
    reg = $2
    val_or_reg = $3
    registers[reg] ||= 0
    val = if val_or_reg.to_i.to_s == val_or_reg
      val_or_reg.to_i
    else
      registers[val_or_reg] ||= 0
    end

    case cmd
    when 'set'
      registers[reg] = val
    when 'sub'
      registers[reg] -= val
    when 'mul'
      registers[reg] *= val
    end
  end
  current += 1
end

ap registers
