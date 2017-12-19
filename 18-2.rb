#!/usr/bin/env ruby

if ARGV.empty?
  puts 'I need the pid I am supposed to be'
  exit 1
end
pid = ARGV[0].to_i
puts "I am program #{pid}"

input = File.readlines('18.txt').map(&:chomp)

infile = File.open('18.stream', 'r')

registers = {'p' => pid, 'z' => 5}
current = 0

while current >= 0 && current < input.size
  puts [current, registers].inspect
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
    cmd = $1
    reg = $2
    registers[reg] ||= 0
    if cmd == 'snd'
      File.open('18.stream', 'a+') do |f|
        f.puts "#{pid}:#{registers[reg]}"
      end
      puts "Sent #{registers[reg]}"
    else
      l = "#{pid}:"
      while l =~ /^#{pid}:/
        sleep 1 until (l = infile.gets)
      end
      registers[reg] = l.split(/:/)[1].to_i
      puts "Read in: #{registers[reg]}"
    end
  end
  current += 1
end

