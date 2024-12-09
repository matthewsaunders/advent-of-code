#!/usr/bin/env ruby

FILENAME = "input.txt"
lines = File.readlines(FILENAME)
nums = lines.map(&:to_i)

num1 = 0
num2 = 0
solved = false
index = 0
MAGIC_NUMBER = 2020

while !solved do
  num1 = nums[index]
  num2 = MAGIC_NUMBER - num1

  if nums.include?(num2)
    solved = true
  end
  index += 1
end

answer = num1 * num2
puts "answer: #{answer}"
