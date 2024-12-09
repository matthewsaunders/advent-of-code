#!/usr/bin/env ruby

FILENAME = "puzzle_1_input.txt"

lines = File.readlines(FILENAME)

def calculate_sq_ft(l, w, h)
  sides = [l,w,h].sort

  2*sides[0] + 2*sides[1] + sides.reduce(&:*)
end

total = 0

lines.each do |l|
  parts = l.split("x").map(&:to_i)
  feet = calculate_sq_ft(parts[0], parts[1], parts[2])
  total += feet
end

puts "answer: #{total}"
