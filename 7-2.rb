#!/usr/bin/env ruby

tower_lines = File.readlines('7.txt').map(&:chomp)

mapping = {}
tower_lines.each do |line|
  results = line.match(/^([^ ]+) \((\d+)\)(| -> (.*))$/)
  mapping[results[1]] = {weight: results[2].to_i}
  if results[4]
    mapping[results[1]][:subs] = results[4].split(/, */)
    puts mapping[results[1]][:subs].inspect
  end
end

changed = true
while changed
  changed = false
  mapping.keys.each do |k|
    next unless mapping[k] && mapping[k][:subs]
    next if mapping[k][:subs].any? {|sk| mapping[sk][:subs] }
    puts "Changing #{k}"
    changed = true
    mapping[k][:tree] = mapping[k][:subs].map do |sk|
      mapping.delete(sk)
    end
    mapping[k].delete(:subs)
  end
end

def determine_weights(frag)
  return [0] if frag == []
  return [0] unless frag
  case frag
  when Hash
    frag[:weight]
  when Array
    frag.map do |e|
      e[:weight] + determine_weights(e[:tree]).reduce(:+)
    end
  end
end

def find_broken(frag)
  results = determine_weights(frag)
  puts frag.map{|s| s[:weight]}.inspect
  puts results.inspect
  things = results.each_with_index.select{|r, i| results.index(r) == i and results.reverse.index(r) == (results.size - i - 1)}
  if things.empty?

  end
  idx = things[0][1]
  find_broken(frag[idx][:tree])
end

find_broken(mapping[mapping.keys.first][:tree])
