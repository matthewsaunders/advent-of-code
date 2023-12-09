#!/usr/bin/env ruby

FILENAME = "input.txt"
EMPTY_SYMBOL = '.'
NUMBERS = (0..9).to_a.map(&:to_s)

lines = File.readlines(FILENAME)

$grid = lines.map{ |line| line.strip.split("") }
$x_max = $grid.length - 1 # subtract 1 because this is a max index
$y_max = $grid[0].length - 1
numbers = []

def number_touches_symbol(x, y)
  x_low = x - 1 < 0 ? 0 : x - 1
  x_high = x + 1 > $x_max ? $x_max : x + 1
  y_low = y - 1 < 0 ? 0 : y - 1
  y_high = y + 1 > $y_max ? $y_max : y + 1

  (x_low..x_high).to_a .each do |i|
    (y_low..y_high).to_a .each do |j|
      char = $grid[i][j]

      if char != EMPTY_SYMBOL && !NUMBERS.include?(char)
        return true
      end
    end
  end

  false
end

(0..$grid.length - 1).each do |i|
  num_str = ""
  add_num = false

  (0..$grid[i].length - 1).each do |j|
    char = $grid[i][j]

    if NUMBERS.include?(char)
      num_str += char
      if !add_num
        add_num = number_touches_symbol(i, j)
      end
    else
      if num_str != ""
        if add_num
          numbers << num_str.to_i
        end

        num_str = ""
        add_num = false
      end
    end

    if j == $grid[i].length - 1 && num_str != ""
      if add_num
        numbers << num_str.to_i
      end

      num_str = ""
      add_num = false
    end

  end
end

sum = numbers.reduce(&:+)

puts "answer: #{sum}"
