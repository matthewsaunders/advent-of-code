#!/usr/bin/env ruby

FILENAME = "input.txt"
# FILENAME = "sample-input.txt"
VERBOSE = false

# The smallest a valid sequence of input chars can be is given in this example:
#   mul(2,4)
SEQUENCE_MIN_SIZE = 8

def numeric?(char)
  char =~ /[0-9]/
end

def calculate_answer(input)
  num_chars = input.length
  i = 0
  values = []
  exit_capture_group = false

  while i < num_chars
    if i + SEQUENCE_MIN_SIZE <= num_chars && input[i..i+3] == "mul("
      puts ".Capturing new value" if VERBOSE

      # skip past initial "mul(" chars
      i += 4
      num1 = ""
      num2 = ""

      # Grab number chars until we hit a valid termination char. For the first number, that is a ','
      while !exit_capture_group && input[i] != ','
        exit_capture_group = true unless numeric?(input[i])

        num1 += input[i]
        i += 1
      end

      puts "..num1: #{num1}" if VERBOSE

      if exit_capture_group
        puts "..exiting capture early num1" if VERBOSE
        exit_capture_group = false
        next
      end

      # swallow ',' char
      i += 1

      # Grab number chars until we hit a valid termination char. For the first number, that is a ')'
      while !exit_capture_group && input[i] != ')'
        exit_capture_group = true unless numeric?(input[i])

        num2 += input[i]
        i += 1
      end

      puts "..num2: #{num2}" if VERBOSE

      if exit_capture_group
        puts "..exiting capture early num2" if VERBOSE
        exit_capture_group = false
        next
      end

      product = num1.to_i * num2.to_i
      values << product

      puts "..product: #{product}" if VERBOSE
    end

    i += 1
  end

  values.reduce(0, :+)
end


lines = File.readlines(FILENAME)
input = lines.join("")

puts input
answer = calculate_answer(input)

puts "answer: #{answer}"

