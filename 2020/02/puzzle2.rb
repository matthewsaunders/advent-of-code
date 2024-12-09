#!/usr/bin/env ruby

FILENAME = "input.txt"

lines = File.readlines(FILENAME)

def is_valid_password?(line)
  parts = line.split(" ")

  low_index = parts[0].split("-")[0].to_i
  high_index = parts[0].split("-")[1].to_i
  letter = parts[1].gsub(":", "")
  password = parts[2]
  count = 0

  count += 1 if password[low_index - 1] == letter
  count += 1 if password[high_index - 1] == letter

  count == 1
end

answer = lines.map { |line| is_valid_password?(line) }.reduce(0) { |sum, l| sum += 1 if l; sum }
puts "answer: #{answer}"
