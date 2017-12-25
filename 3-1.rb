#!/usr/bin/env ruby

input = 325489

assembler = []
#17 16 15 14 13
#18  5  4  3 12
#19  6  1  2 11
#20  7  8  9 10
#21 22 23 24 25


(1..1000).step(2) do |i|
  bottom_right = i**2
  if bottom_right > input
    width = i
    bottom_left = bottom_right - width + 1
    top_left = bottom_left - width + 1
    top_right = top_left - width + 1
    corners = [bottom_right, bottom_left, top_left, top_right]
    puts (corners + [width]).inspect
    halfway_dist = (width - 1) / 2
    midpoints = corners.map{|i| i - halfway_dist}
    closest_dist_to_mid = midpoints.map do |mid|
      (mid - input).abs
    end.min

    total_steps = closest_dist_to_mid + halfway_dist
    puts total_steps

    break
  end

end
