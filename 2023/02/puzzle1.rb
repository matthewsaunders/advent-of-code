#!/usr/bin/env ruby

FILENAME = "input.txt"

MAX_RED = 12
MAX_GREEN = 13
MAX_BLUE = 14

def parse_move_into_parts(move)
  parts = move.split(" ").map(&:strip)
  [Integer(parts[0]), parts[1]]
end

def get_game_move_sets(line)
  raw_sets = line.split(":")[1].split(";").map(&:strip)
  raw_sets.map { |set| set.split(",").map(&:strip).map{ |move| parse_move_into_parts(move) } }
end

def is_move_possible?(color, count)
  if color == "red"
    return count <= MAX_RED
  elsif color == "green"
    return count <= MAX_GREEN
  else
    return count <= MAX_BLUE
  end
end

def is_instance_possible?(moves)
  moves.all? { |move| is_move_possible?(move[1], move[0]) }
end

def is_game_possible?(sets)
  sets.all? { |instance| is_instance_possible?(instance) }
end

sum = 0
lines = File.readlines(FILENAME)

lines.each_with_index do |line, index|
  sets = get_game_move_sets(line)
  sum += (index + 1) if is_game_possible?(sets)
end

puts "answer: #{sum}"
