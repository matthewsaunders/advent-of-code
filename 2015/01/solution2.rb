#!/usr/bin/env ruby

FILENAME = "puzzle_1_input.txt"
lines = File.readlines(FILENAME)

input = lines[0].strip.split("")

sum = 0
answer = 0
input.each_with_index do |x, index|
  x == "(" ? sum += 1 : sum -= 1

  if sum < 0
    answer = index + 1 # Add 1 because index by 0
    break
  end
end

puts "answer: #{answer}"
