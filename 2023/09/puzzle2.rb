#!/usr/bin/env ruby

FILENAME = "input.txt"

lines = File.readlines(FILENAME)
values = []

def all_zeros?(arr)
  arr = arr.uniq
  arr.length == 1 and arr[0] == 0
end

def print_arr(arr)
  arr.join(" ")
end

lines.each do |line|
  arr = line.strip.split(" ").map(&:to_i)
  iterations = [arr]

  while !all_zeros?(arr)
    new_arr = []

    (0..arr.length - 2).to_a.each do |i|
      new_arr << arr[i+1] - arr[i]
    end

    arr = new_arr
    iterations << arr
  end

  # puts "iterations"
  # iterations.each_with_index do |iter, i|
  #   puts "..#{i} - #{print_arr(iter)}"
  # end

  value = 0
  (0..iterations.length - 2).to_a.reverse.each do |i|
    value = iterations[i][0] - value
  end

  values << value
end

# puts "values"
# puts print_arr(values)

sum = values.reduce(&:+)

puts "answer: #{sum}"
