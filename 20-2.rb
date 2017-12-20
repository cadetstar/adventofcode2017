#!/usr/bin/env ruby

input = File.readlines('20.txt').map(&:chomp)

class Tuple3
  attr_accessor :x, :y, :z
  def initialize(x, y, z)
    @x = x.to_i
    @y = y.to_i
    @z = z.to_i
  end

  def inspect
    "[#{x}, #{y}, #{z}]"
  end

  def net_manhattan
    @x.abs + @y.abs + @z.abs
  end

  def ==(other)
    @x == other.x && @y == other.y && @z == other.z
  end

  def +(other)
    @x += other.x
    @y += other.y
    @z += other.z
    self
  end
end

class Point
  attr_accessor :idx, :p, :v, :a
  def initialize(idx, str)
    @idx = idx
    str.match(/p=<([^,]+),([^,]+),([^,]+)>, v=<([^,]+),([^,]+),([^,]+)>, a=<([^,]+),([^,]+),([^,]+)>/) do |mdata|
      @p = Tuple3.new(*mdata[1, 3])
      @v = Tuple3.new(*mdata[4, 3])
      @a = Tuple3.new(*mdata[7, 3])
    end
  end

  def inspect
    width = 22
    "P: %#{width}s, V: %#{width}s, A: %#{width}s" % [@p.inspect, @v.inspect, @a.inspect]
  end

  def net_manhattan_accel
    @a.net_manhattan
  end
  def net_manhattan_vel
    @v.net_manhattan
  end

  def collides?(other)
    @p == other.p
  end

  def tick!
    @v += @a
    @p += @v
  end

  def ==(other)
    other.idx == @idx
  end
end

point_data = input.each_with_index.map { |l, i| Point.new(i, l) }

num_nils = 0

loop do
  prior = point_data.size
  point_data.delete_if do |r|
    point_data.any? do |j|
      r != j && r.collides?(j)
    end
  end
  if prior == point_data.size
    num_nils += 1
  else
    num_nils = 0
  end
  puts point_data.size
  point_data.each(&:tick!)
  puts point_data[0].inspect
  break if num_nils > 30
end

require 'awesome_print'

ap point_data
