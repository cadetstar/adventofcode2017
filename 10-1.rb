list_size = 256

arr = (0...list_size).to_a

adjustments = [197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63]

total_rot = 0
adjustments.each_with_index do |adj, i|
  mod_arr = arr.slice!(0,adj)
  arr = mod_arr.reverse + arr
  to_rotate = adj + i
  total_rot += to_rotate
  arr = arr.rotate(to_rotate)
end

arr = arr.rotate(-1 * total_rot)
puts arr.inspect

puts arr[0] * arr[1]
