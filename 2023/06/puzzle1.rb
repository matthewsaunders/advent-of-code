#!/usr/bin/env ruby

FILENAME = "input.txt"

lines = File.readlines(FILENAME)

times = lines[0].gsub("Time:", "").split(" ").map { |x| Integer(x.strip) }
distances = lines[1].gsub("Distance:", "").split(" ").map { |x| Integer(x.strip) }
total_num_wins = []

times.each_with_index do |t, i|
  winning_dst = distances[i]
  num_wins = (0..t).to_a.reduce(0) do |sum, t_held|
    dst = t_held * (t - t_held)
    dst > winning_dst ? sum + 1 : sum
  end

  total_num_wins << num_wins
end

product = total_num_wins.reduce(:*)

puts "answer: #{product}"
