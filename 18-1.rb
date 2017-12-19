#!/usr/bin/env ruby

input = File.readlines('18.txt').map(&:chomp)

registers = {}
last_sound = 0
current = 0

while current >= 0 and current < input.size
  case input[current]
  when /^(set|mul|add|mod|jgz) (.) (.+)$/
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
    when 'mul'
      registers[reg] *= val
    when 'add'
      registers[reg] += val
    when 'mod'
      registers[reg] %= val
    when 'jgz'
      if registers[reg] > 0
        current += val
        next
      end
    end
  when /^(snd|rcv) (.)$/
    registers[$2] ||= 0
    if $1 == 'snd'
      last_sound = registers[$2]
    else
      if registers[$2] != 0
        puts "Last sound: #{last_sound}"
        exit 0
      end
    end
  end
  current += 1
end
