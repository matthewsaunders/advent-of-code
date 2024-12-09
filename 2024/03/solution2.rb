#!/usr/bin/env ruby

# 81773678 - too low

FILENAME = "input.txt"
# FILENAME = "sample-input-2.txt"
VERBOSE = false

# The smallest a valid sequence of input chars can be is given in this example:
#   mul(2,4)
SEQUENCE_MIN_SIZE = 8

def numeric?(char)
  char =~ /[0-9]/
end

def calculate_answer(input)
  puts input if VERBOSE

  num_chars = input.length
  i = 0
  values = []
  exit_capture_group = false
  enabled = true

  while i < num_chars
    if i + SEQUENCE_MIN_SIZE > num_chars
      i += SEQUENCE_MIN_SIZE # force loop exit
    elsif input[i..i+3] == "do()"
      enabled = true
      i += 4

      puts "..DO STATEMENT" if VERBOSE
      puts "..enabled: #{enabled}" if VERBOSE
    elsif input[i..i+6] == "don't()"
      enabled = false
      i += 7

      puts "..DON'T STATEMENT" if VERBOSE
      puts "..enabled: #{enabled}" if VERBOSE
    elsif input[i..i+3] == "mul("
      puts "..Capturing new value" if VERBOSE

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
      values << product if enabled

      puts "..product: #{product}" if VERBOSE
    else
      i += 1
    end
  end

  values.reduce(0, :+)
end


lines = File.readlines(FILENAME)
input = lines.join("")
answer = calculate_answer(input)

puts "answer: #{answer}"

