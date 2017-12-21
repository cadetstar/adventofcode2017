#!/usr/bin/env ruby

require 'active_support/core_ext/array/grouping'
require 'byebug'

input = File.readlines('21.txt').map(&:chomp)

#input = ['../.# => ##./#../...', '.#./..#/### => #..#/..../..../#..#']

rules = {}
input.each do |line|
  k, v = *line.split(/ => /)
  rules[k] = v
end

class Picture
  def initialize(rules)
    @rules = rules
    @display = [%w(. # .), %w(. . #), %w(# # #)]
  end

  def mutate!
    size = @display.size.even? ? 2 : 3
    assembled_rules = @display.in_groups_of(size).map do |rowset|
      (0...rowset[0].size).to_a.in_groups_of(size).map do |colidxset|
        row_thing = rowset.map{|r| r[colidxset.min..colidxset.max].join('')}.join('/')
        all_rules = row_flips(row_thing).map do |m|
          @rules[m]
        end.compact.uniq
        if all_rules.size > 1
          byebug
          print 1
        end
        all_rules.first
      end
    end
    new_display = []
    assembled_rules.each do |rule_row|
      (size + 1).times do |i|
        drow = []
        rule_row.each do |rule|
          drow += rule.split('/')[i].split(//)
        end
        new_display << drow
      end
    end
    @display = new_display
  end

  def display!
    puts '-' * (@display.size + 4)
    @display.each do |row|
      puts '  ' + row.join('')
    end
    puts '-' * (@display.size + 4)
  end

  def lit_up_count
    @display.map do |row|
      row.count{|s| s == '#'}
    end.reduce(:+)
  end

  private

  def row_flips(row)
    set = []
    row.match /^(.)(.)\/(.)(.)$/ do |m|
      set << parse_piece(m, [[1,2],[3,4]])
      set << parse_piece(m, [[3,1],[4,2]])
      set << parse_piece(m, [[4,3],[2,1]])
      set << parse_piece(m, [[2,4],[1,3]])
      set << parse_piece(m, [[2,1],[4,3]])
      set << parse_piece(m, [[4,2],[3,1]])
      set << parse_piece(m, [[3,4],[1,2]])
      set << parse_piece(m, [[1,3],[2,4]])
    end
    row.match /(.)(.)(.)\/(.)(.)(.)\/(.)(.)(.)/ do |m|
      [[1,2,3,6,9,8,7,4], [3,2,1,4,7,8,9,6]].each do |starter|
        4.times do |i|
          l = starter.rotate(2 * i)
          set << parse_piece(m, [[l[0], l[1], l[2]], [l[7], 5, l[3]], [l[6], l[5], l[4]]])
        end
      end
    end

    set
  end

  def parse_piece(mdata, instr)
    instr.map do |row|
      row.map {|s| mdata[s]}.join('')
    end.join('/')
  end
end

r = Picture.new(rules)
r.display!
18.times do
  r.mutate!
  r.display!
end

puts r.lit_up_count
