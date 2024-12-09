#!/usr/bin/env ruby

FILENAME = "input.txt"

lines = File.readlines(FILENAME)

grid = []
lines.each { |l| grid << l.strip.split("") }

TREE_CHAR = "#"
SLOPE_X = 3
SLOPE_Y = 1

position_x = 0
position_y = 0
count = 0
width = grid[0].length

while position_y < grid.length do
  count += 1 if grid[position_y][position_x % width] == TREE_CHAR

  position_x += SLOPE_X
  position_y += SLOPE_Y
end

puts "answer: #{count}"
