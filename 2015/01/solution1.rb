#!/usr/bin/env ruby

FILENAME = "puzzle_1_input.txt"
lines = File.readlines(FILENAME)

input = lines[0].strip.split("")
answer = input.reduce(0) { |sum, x| x == "(" ? sum + 1 : sum - 1 }
puts "answer: #{answer}"
