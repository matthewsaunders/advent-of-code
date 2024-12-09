#/usr/bin/env ruby

FILENAME = "input.txt"
EMPTY_LINE = "\n"

lines = File.readlines(FILENAME)

MANDO_FIELDS = %w[ byr iyr eyr hgt hcl ecl pid cid ]

# process input into passport lines
passports = []
current = ""

lines.each_with_index do |line, index|
  if line == EMPTY_LINE
    passports << current.strip
    current = ""
  else
    current += " #{line.strip}"
  end
end

def is_passport_valid?(passport)
  fields = passport.split(" ")
  keys = fields.map { |f| f.split(":")[0] }

  fields.length == MANDO_FIELDS.length ||
  (fields.length == MANDO_FIELDS.length - 1 && !keys.include?("cid"))
end

answer = passports.reduce(0) { |sum, passport| sum += 1 if is_passport_valid?(passport); sum }
puts "answer: #{answer}"
