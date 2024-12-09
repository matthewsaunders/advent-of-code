#!/usr/bin/env ruby

FILENAME = "input.txt"

lines = File.readlines(FILENAME)

def is_valid_password?(line)
  parts = line.split(" ")

  min = parts[0].split("-")[0].to_i
  max = parts[0].split("-")[1].to_i
  letter = parts[1].gsub(":", "")
  password = parts[2]

  count = password.split("").reduce(0) { |sum, n| sum += 1 if n == letter; sum }

  count >= min && count <= max
end

answer = lines.map { |line| is_valid_password?(line) }.reduce(0) { |sum, l| sum += 1 if l; sum }
puts "answer: #{answer}"
