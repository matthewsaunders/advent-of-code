#!/usr/bin/env ruby

FILENAME = "input.txt"
LETTERS_REGEX = /[A-Za-z]/
NUMBERS_REGEX = /[0-9]/
SPELT_NUMBERS_MAP = {
  "one": "1",
  "two": "2",
  "three": "3",
  "four": "4",
  "five": "5",
  "six": "6",
  "seven": "7",
  "eight": "8",
  "nine": "9",
}
SPELT_NUMBERS = SPELT_NUMBERS_MAP.keys.map(&:to_s)

def process_spelt_letters(str)
  i = 0
  str_length = str.length
  new_str = ''

  while i < str_length
    # if we find a number, add it to string and move on
    if NUMBERS_REGEX.match?(str[i])
      new_str += str[i]
      i+=1
      next
    end

    # check for three letter numbers
    if i + 3 <= str.length
      three_letter_substr = str[i..i+2]
      if SPELT_NUMBERS.include?(three_letter_substr)
        new_str += SPELT_NUMBERS_MAP[three_letter_substr.to_sym]
        i += 1
        next
      end
    end

    # check for four letter numbers
    if i + 4 <= str.length
      four_letter_substr = str[i..i+3]
      if SPELT_NUMBERS.include?(four_letter_substr)
        new_str += SPELT_NUMBERS_MAP[four_letter_substr.to_sym]
        i += 1
        next
      end
    end

    # check for five letter numbers
    if i + 5 <= str.length
      three_letter_substr = str[i..i+4]
      if SPELT_NUMBERS.include?(three_letter_substr)
        new_str += SPELT_NUMBERS_MAP[three_letter_substr.to_sym]
        i += 1
        next
      end
    end

    # we stumbled on a random letter
    i+=1
  end

  new_str
end

def filter_out_letters(str)
  str.chars.reject { |ch| LETTERS_REGEX.match?(ch) }.join('')
end

def get_calibration_value(str)
  Integer(str[0] + str[-1])
end

lines = File.readlines(FILENAME).map(&:strip)
lines_with_spelt_numbers = lines.map { |line| process_spelt_letters(line) }
number_str = lines_with_spelt_numbers.map { |line| filter_out_letters(line) }
numbers = number_str.map { |str| get_calibration_value(str) }
answer = numbers.reduce(:+)

puts "Answer: #{answer}"
