#!/usr/bin/env ruby

instructions = File.readlines('8.txt').map(&:chomp)

registers = {}

instructions.each do |line|
  reg, inst, value, if_hold, comp_reg, comp_type, comp_value = *line.split(' ')

  if if_hold != 'if'
    puts "If Hold not expected: #{if_hold}"
  end
  registers[reg] ||= 0

  comp_reg_value = (registers[comp_reg] ||= 0)

  check_result = comp_reg_value.send(comp_type.to_sym, comp_value.to_i)
  puts [comp_reg_value, comp_type, comp_value, check_result].inspect
  if check_result
    case inst
    when "inc"; registers[reg] += value.to_i
    when "dec"; registers[reg] -= value.to_i
    else
      puts "Unknown inst: #{inst}"
    end
  end

end

puts registers.values.max

