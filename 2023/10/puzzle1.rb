#!/usr/bin/env ruby

FILENAME = "sample-input2.txt"

# Input symbols
GROUND =              "."
START_POSITION =      "S"
VERT_PIPE =           "|"
HORIZ_PIPE =          "-"
UP_RIGHT_BEND_PIPE =  "F"
RIGHT_DOWN_PIPE =     "7"
DOWN_LEFT_BEND_PIPE = "J"
LEFT_UP_BEND_PIPE =   "L"

lines = File.readlines(FILENAME)

puts lines[1]

=begin

THE PLAN:

1. Find the start position
2. From the start position, walk a path in every direction looking for a cycle
  a. Also measure length of cycle
3. Once the cycle is found, distance equals half the length ceil

=end

max_x = lines[0].length - 1
max_y = lines.length - 1

# find start
start_x = 0
start_y = 0

(0..max_y).to_a.each do |i|
  (0..max_x).to_a.each do |j|
    if lines[i][j] == START_POSITION
      start_x = j
      start_y = i
    end
  end
end

puts "start: (#{start_x}, #{start_y})"

solved = false
breakpoint = 0

x_moves
if start_x == 0

elsif start_x == max_x

else

end

moves = []

while !solved && breakpoint != 5





  breakpoint += 1
end
