#!/usr/bin/env ruby

input = 325489

$holder = {}

$holder[[0,0]] = 1


def get_value_for_coord(coord)
  [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]].map do |vars|
    $holder[[coord[0]+vars[0],coord[1]+vars[1]]] || 0
  end.reduce(:+)
end

max = 51
(3..max).step(2).each do |i|
  outer = (i - 1) / 2
  ordering = (
    ((-outer + 1)..outer).map{|z| [z,outer]} +
    (-outer..outer).map{|z| [outer, z]}.reverse +
    (-outer..outer).map{|z| [z, -outer]}.reverse +
    (-outer..outer).map{|z| [-outer, z]} +
    [[-outer, outer]]
  ).uniq
  ordering.each do |o|
    $holder[o] = get_value_for_coord(o)
    if $holder[o] > input
      puts $holder[o]
      break
    end
  end
end

outer = (max - 1) / 2
(-outer..outer).to_a.reverse.each do |i|
  (-outer..outer).each do |j|
    print '%12d' % ($holder[[i,j]] || 0)
  end
  puts ''
end
