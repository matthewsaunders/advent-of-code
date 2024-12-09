#!/usr/bin/env ruby

FILENAME = "input.txt"

lines = File.readlines(FILENAME)

puts lines

def binary_search_val(moves, low_move, high_move)
  min = 0
  max = 2 ** moves.length - 1

  puts moves.join("")

  moves.each_with_index do |move, index|
    step = 2 ** (moves.length - index - 1)
    puts "#{index}: [#{min}, #{max}]"

    if move == low_move
      max = max - step
    else
      min = min + step
    end
  end

  puts " ==>[#{min}, #{max}]"

  # both min and max should be the same value by now
  max
end

def get_row_num(pass)
  moves = pass[0..6].split("")
  binary_search_val(moves, "F", "B")
end

def get_col_num(pass)
  moves = pass[7..9].split("")
  binary_search_val(moves, "L", "R")
end

def get_seat_id(pass)
  row = get_row_num(pass)
  col = get_col_num(pass)

  puts "row: #{row}, col: #{col}"

  row * 8 + col
end

ids = lines.map { |pass| get_seat_id(pass) }

puts "answer: #{ids.max}"
