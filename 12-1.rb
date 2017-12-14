#!/usr/bin/env ruby

text = File.readlines('12.txt').map(&:chomp)

mapper = {}

text.each do |line|
  source, dests = line.split(' <-> ')
  destinations = dests.split(/, */).map(&:to_i)
  source = source.to_i

  mapper[source] ||= []
  mapper[source] = (mapper[source] + destinations).uniq
  destinations.each do |d|
    mapper[d] ||= []
    mapper[d] << source
    mapper[d].uniq!
  end
end

require 'awesome_print'
i = 0
loop do
  puts "Loop #{i += 1}"
  changed = false
  mapper.keys.each do |k|
    next unless mapper[k]
    next if mapper[k] == [k]
    if mapper[k].any? {|s| mapper[s]} or mapper.values.any?{|arr| arr.include?(k)}
      mapper[k] = mapper[k].map{|s| [s] + (mapper.delete(s) || [])}.flatten.uniq

      absorbed = false
      mapper.each_pair do |inner_k,v|
        next if inner_k == k
        if v.include? k
          absorbed = true
          mapper[inner_k] = (mapper[k] + mapper[inner_k]).flatten
        end
      end
      if absorbed
        mapper.delete(k)
        changed = true
      end
    end

    mapper.keys.each do |inner_k|
      v = mapper[inner_k]
      next if k == inner_k
      next unless mapper[k]
      next unless (v & mapper[k]).any?
      next if mapper[k].include?(inner_k)
      #puts [k, inner_k, mapper[k], v].inspect
      changed = true
      mapper[k] = (mapper[k] + mapper.delete(inner_k)).flatten.uniq
    end
  end
  puts mapper.values.flatten.size
  break unless changed
end

puts mapper.values.flatten.uniq.size

includes0 = mapper.values.select{|v| v.include?(0)}.first

ap mapper
puts includes0.inspect
puts includes0.size
puts mapper.keys.size
