#!/usr/bin/env ruby

text = File.read('9.txt').chomp

def filter(text)
  text.gsub!(/!./, '')

  total = 0
  loop do
    ntext = text.gsub(/^([^<]*)<.*?>/, '\1')
    break if ntext == text
    total += (text.size - ntext.size - 2)
    text = ntext
  end
  puts total
  text
end

result = filter(text)
text = result
until text !~ /\{/
  text.gsub!(/\{([^\{\}]*)\}/) do |_|
    inner = $1.split(//)
    'a' + inner.map do |i|
      case i
      when ','
        nil
      when /[a-z]/
        (i.ord + 1).chr
      else
        puts "Unknown marker: #{i}"
      end
    end.compact.join
  end
end

puts text
result = ('a'..'z').each_with_index.map do |c, i|
  text.count(c) * (i + 1)
end.reduce(:+)

puts result
