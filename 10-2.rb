list_size = 256

arr = (0...list_size).to_a

input = '197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63'
input = '197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63'
adjustments = input.split(//).map(&:ord) + [17, 31, 73, 47, 23]

puts adjustments.inspect
total_rot = 0
(0...64).each do |iter|
  adjustments.each_with_index do |adj, i|
    mod_arr = arr.slice!(0,adj)
    arr = mod_arr.reverse + arr
    to_rotate = adj + i + iter * adjustments.size
    total_rot += to_rotate
    arr = arr.rotate(to_rotate)
  end
end

arr = arr.rotate(-1 * total_rot)
puts arr.inspect
puts arr.size

result = arr.each_slice(16).map do |sub|
  '%02x' % sub.reduce(:^)
end.join
puts result
