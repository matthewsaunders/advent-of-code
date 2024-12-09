#!/usr/bin/env ruby

FILENAME = "input.txt"

lines = File.readlines(FILENAME)

grid = []
lines.each { |l| grid << l.strip.split("") }

TREE_CHAR = "#"
SLOPE_X = 3
SLOPE_Y = 1

slopes = [
  { x: 1, y: 1 },
  { x: 3, y: 1 },
  { x: 5, y: 1 },
  { x: 7, y: 1 },
  { x: 1, y: 2 },
]

def tree_count_on_path(grid, slope)
  position_x = 0
  position_y = 0
  count = 0
  width = grid[0].length

  while position_y < grid.length do
    count += 1 if grid[position_y][position_x % width] == TREE_CHAR

    position_x += slope[:x]
    position_y += slope[:y]
  end

  count
end

counts = slopes.map { |slope| tree_count_on_path(grid, slope) }
answer = counts.reduce(:*)

puts "answer: #{answer}"
