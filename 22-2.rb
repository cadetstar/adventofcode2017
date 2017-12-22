#!/usr/bin/env ruby

require 'active_support/core_ext/array/grouping'
require 'byebug'

input = File.readlines('22.txt').map(&:chomp)

#input = ['..#','#..','...']

class Infector
  def initialize(input)
    @curmap = {}
    @directions = [[0,1],[1,0],[0,-1],[-1,0]]
    @position = [0,0]
    input.each_with_index do |row, i|
      row.split(//).each_with_index do |col, j|
        ypos = (input.size - 1) / 2 - i
        xpos = j - (input.size - 1) / 2
        @curmap[[xpos,ypos]] = col
      end
    end
  end

  def pulse!
    caused = false
    case @curmap[@position]
    when '#'
      @directions.rotate!(1)
      @curmap[@position] = 'F'
    when 'W'
      @curmap[@position] = '#'
      caused = true
    when 'F'
      @directions.rotate!(2)
      @curmap[@position] = '.'
    else
      @directions.rotate!(-1)
      @curmap[@position] = 'W'
    end
    move!
    caused
  end

  def move!
    @position[0] += @directions[0][0]
    @position[1] += @directions[0][1]
  end

  def display!(iter = 0)
    xs = (@curmap.keys.map{|s| s[0]} + [@position[0]]).uniq
    ys = (@curmap.keys.map{|s| s[1]} + [@position[1]]).uniq
    width = xs.max - xs.min + 1
    puts '-' * (width + 4)
    puts " #{iter}"
    puts '-' * (width + 4)
    (ys.min..ys.max).to_a.reverse.each do |y|
      print '  '
      (xs.min..xs.max).each do |x|
        print "\e[32m" if [x,y] == @position
        print @curmap[[x,y]] || '.'
        print "\e[0m" if [x,y] == @position
      end
      puts ''
    end
    puts '-' * (width + 4)
  end
end

i = Infector.new(input)
i.display!
total = 0
10_000_000.times do |j|
  puts j if j % 100_000 == 0
  total += 1 if i.pulse!
  #i.display!(j + 1)
end

#puts i.display!(10_000)
puts "Total pulses causing infection: #{total}"
