#!/usr/bin/env ruby

FILENAME = "input.txt"
LETTERS_REGEX = /[A-Za-z]/

def filter_out_letters(str)
  str.chars.reject { |ch| LETTERS_REGEX.match?(ch) }.join('').chomp
end

def get_calibration_value(str)
  Integer(str[0] + str[-1])
end

lines = File.readlines(FILENAME)
number_str = lines.map { |line| filter_out_letters(line) }
numbers = number_str.map { |str| get_calibration_value(str) }
answer = numbers.reduce(:+)

puts "Answer: #{answer}"
