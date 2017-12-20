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
end

class Point
  attr_accessor :p, :v, :a
  def initialize(str)
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
end

point_data = input.map { |l| Point.new l }

require 'awesome_print'
ap point_data

min_accel = point_data.map{|r| r.net_manhattan_accel}.min
puts min_accel
lowest_elems = point_data.select{|r| r.net_manhattan_accel == min_accel}
min_vel = lowest_elems.map{|r| r.net_manhattan_vel}.min
puts min_vel
lowest_elem = lowest_elems.select{|r| r.net_manhattan_vel == min_vel}.first
puts point_data.index(lowest_elem)
