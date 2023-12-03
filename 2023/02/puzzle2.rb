#!/usr/bin/env ruby

FILENAME = "input.txt"

def parse_move_into_parts(move)
  parts = move.split(" ").map(&:strip)
  [Integer(parts[0]), parts[1]]
end

def get_game_move_sets(line)
  raw_sets = line.split(":")[1].split(";").map(&:strip)
  raw_sets.map { |set| set.split(",").map(&:strip).map{ |move| parse_move_into_parts(move) } }
end

def game_power(sets)
  max_red = 0
  max_blue = 0
  max_green = 0

  sets.each do |set|
    set.each do |move|
      if move[1] == "red"
        max_red = move[0] if move[0] > max_red
      elsif move[1] == "green"
        max_green = move[0] if move[0] > max_green
      else
        max_blue = move[0] if move[0] > max_blue
      end
    end
  end

  max_red * max_blue * max_green
end

sum = 0
lines = File.readlines(FILENAME)

lines.each_with_index do |line, index|
  sets = get_game_move_sets(line)
  sum += game_power(sets)
end

puts "answer: #{sum}"
