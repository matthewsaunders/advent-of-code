#!/usr/bin/env ruby

FILENAME = "input.txt"
EMPTY_SYMBOL = '.'
GEAR_SYMBOL = '*'
NUMBERS = (0..9).to_a.map(&:to_s)

lines = File.readlines(FILENAME)

$grid = lines.map{ |line| line.strip.split("") }
$x_max = $grid.length - 1 # subtract 1 because this is a max index
$y_max = $grid[0].length - 1
$numbers = []
$gears = []

class Number
  def initialize(value, x_pos_start, x_pos_end, y_pos)
    @value = value
    @x_pos_start = x_pos_start
    @x_pos_end = x_pos_end
    @y_pos = y_pos
  end

  def value
    @value
  end

  def touches_gear(gear)
    x_low = @x_pos_start - 1 < 0 ? 0 : @x_pos_start - 1
    x_high = @x_pos_end + 1 > $x_max ? $x_max : @x_pos_end + 1
    y_low = @y_pos - 1 < 0 ? 0 : @y_pos - 1
    y_high = @y_pos + 1 > $y_max ? $y_max : @y_pos + 1

    gear.y >= y_low && gear.y <= y_high &&
    gear.x >= x_low && gear.x <= x_high
  end

  def to_s
    "#{@value} - [#{@x_pos_start}-#{@x_pos_end}, #{@y_pos}]"
  end
end

class Gear
  def initialize(x, y)
    @x = x
    @y = y
    @numbers = []
  end

  def x
    @x
  end

  def y
    @y
  end

  def numbers
    @numbers.map(&:value)
  end

  def add_number(num)
    @numbers << num
  end

  def to_s
    "[#{@x}, #{@y}] - #{self.numbers.join(" ")}"
  end
end

# Populate numbers
(0..$grid.length - 1).each do |i|
  num_str = ""
  x_pos_start = nil
  x_pos_end = nil
  y_pos = nil

  (0..$grid[i].length - 1).each do |j|
    char = $grid[i][j]

    if NUMBERS.include?(char)
      num_str += char

      y_pos = i
      if !x_pos_start
        x_pos_start = j
      end
    else
      if num_str != ""
        x_pos_end = j - 1

        $numbers << Number.new(num_str.to_i, x_pos_start, x_pos_end, y_pos)
        x_pos_start = nil
        x_pos_end = nil
        y_pos = nil
        num_str = ""
      end
    end

    if j == $grid[i].length - 1 && num_str != ""
      x_pos_end = j - 1

      $numbers << Number.new(num_str.to_i, x_pos_start, x_pos_end, y_pos)
      x_pos_start = nil
      x_pos_end = nil
      y_pos = nil
      num_str = ""
    end
  end
end

# Populate gears
(0..$grid.length - 1).each do |i|
  (0..$grid[i].length - 1).each do |j|
    char = $grid[i][j]

    if char == GEAR_SYMBOL
      $gears << Gear.new(j,i)
    end
  end
end

# Add numbers to gears
$numbers.each do |n|
  $gears.each do |g|
    if n.touches_gear(g)
      g.add_number(n)
    end
  end
end

# Filter gears without 2 numbers
$gears = $gears.filter { |g| g.numbers.length == 2 }
sum = $gears.reduce(0) { |sum, g| sum += g.numbers.reduce(&:*) }

puts "answer: #{sum}"
