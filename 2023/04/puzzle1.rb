#!/usr/bin/env ruby

FILENAME = "input.txt"

def parse_num_array(str)
  str.split(" ").map(&:strip)
end

def game_card_points(card)
  parts = card.split("|")

  winning_numbers = parse_num_array(parts[0])
  given_numbers = parse_num_array(parts[1])
  points = 0

  given_numbers.each do |num|
    next unless winning_numbers.include?(num)

    points = points == 0 ? 1 : points * 2
  end

  puts "..points: #{points}"
  points
end

sum = 0
lines = File.readlines(FILENAME)

lines.each do |line|
  line = line.split(":")[1]   # remove leading "Card #:"
  sum += game_card_points(line)
end

puts "answer: #{sum}"
