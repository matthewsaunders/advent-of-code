#!/usr/bin/env ruby

FILENAME = "input.txt"
lines = File.readlines(FILENAME)
nums = lines.map(&:to_i)

def get_numbers_that_add_to_sum(arr, sum)
  num1 = 0
  num2 = 0
  index = 0

  while index < arr.length do
    num1 = arr[index]
    num2 = sum - num1

    if arr.include?(num2)
      return [num1, num2]
    end

    index += 1
  end

  nil
end


solved = false
index = 0
MAGIC_NUMBER = 2020
matching_numbers = []

while !solved do
  num = nums[index]
  other_sum = MAGIC_NUMBER - num

  other_nums = get_numbers_that_add_to_sum(nums[index+1..nums.length-1], other_sum)

  puts "num: #{num}"
  puts "other_nums: #{other_nums}"

  if other_nums
    matching_numbers << num
    matching_numbers.concat(other_nums)
    solved = true
  end
  index += 1
end

answer = matching_numbers.reduce(:*)
puts "answer: #{answer}"
