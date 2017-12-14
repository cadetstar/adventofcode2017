#!/usr/bin/env ruby


key_string = 'amgozmfv'
#key_string = 'flqrgnkx'

rows = (0..127).map{|i| "#{key_string}-#{i}"}

list_size = 256
base_arr = (0...list_size).to_a

full_map = {}

rows.each_with_index do |row, j|
  lengths = row.split(//).map(&:ord) + [17, 31, 73, 47, 23]
  total_rot = 0
  arr = base_arr.dup
  (0...64).each do |iter|
    lengths.each_with_index do |adj, i|
      mod_arr = arr.slice!(0,adj)
      arr = mod_arr.reverse + arr
      to_rotate = adj + i + iter * lengths.size
      total_rot += to_rotate
      arr = arr.rotate(to_rotate)
    end
  end
  arr = arr.rotate(-1 * total_rot)
  result = arr.each_slice(16).map {|sub| '%08b' % sub.reduce(:^)}.join
  puts [row.split('-')[1], result].inspect
  result.split(//).each_with_index do |v, z|
    if v == '1'
      full_map[[j, z]] = 1
    end
  end
end

$full_map = full_map

def delete_adjacent(k)
  [
    [k[0], k[1] + 1],
    [k[0], k[1] - 1],
    [k[0] + 1, k[1]],
    [k[0] - 1, k[1]]
  ].each do |adj|
    if $full_map[adj]
      $full_map.delete(adj)
      delete_adjacent(adj)
    end
  end
end

regions = 0
until $full_map.empty?
  k = $full_map.keys.first
  regions += 1
  $full_map.delete(k)
  a = $full_map.size
  delete_adjacent(k)
  puts [a, $full_map.size].inspect
end
puts regions
