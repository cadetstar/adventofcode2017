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

puts mapping.inspect
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
puts mapping.inspect
puts mapping.keys
