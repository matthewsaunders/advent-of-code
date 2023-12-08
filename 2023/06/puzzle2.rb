#!/usr/bin/env ruby

FILENAME = "input.txt"

lines = File.readlines(FILENAME)

time = lines[0].gsub("Time:", "").split(" ").map(&:strip).join("").to_i
distance = lines[1].gsub("Distance:", "").split(" ").map(&:strip).join("").to_i

num_wins = (0..time).to_a.reduce(0) do |sum, t_held|
  dst = t_held * (time - t_held)
  dst > distance ? sum + 1 : sum
end

puts "answer: #{num_wins}"
