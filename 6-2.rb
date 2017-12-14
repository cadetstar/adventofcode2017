#!/usr/bin/env ruby

require 'set'

banks = File.read('6.txt').chomp.split(/\t/).map(&:to_i)

configurations = []

def fix_banks(banks)
  idx = banks.index(banks.max)

  total = banks[idx]
  banks[idx] = 0
  while total > 0
    idx += 1
    if idx >= banks.size
      idx = 0
    end
    banks[idx] += 1
    total -= 1
  end
end

count = 0

new_config = banks.join('-')
until configurations.include?(new_config)
  configurations << new_config
  puts new_config
  fix_banks(banks)
  count += 1
  new_config = banks.join('-')
end
puts banks.inspect
puts count
puts configurations.index(new_config)
