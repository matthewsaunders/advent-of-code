#/usr/bin/env ruby

FILENAME = "input.txt"
EMPTY_LINE = "\n"

lines = File.readlines(FILENAME)

MANDO_FIELDS = %w[ byr iyr eyr hgt hcl ecl pid cid ]
HCL_REGEX = /^#[0-9a-z]{6}$/
VALID_ECL = %w[ amb blu brn gry grn hzl oth ]
PID_REGEX = /^\d{9}$/

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

# Add the last line to passports
passports << current.strip

puts ""
puts passports
puts ""

def required_fields_present?(fields)
  keys = fields.keys

  keys.length == MANDO_FIELDS.length ||
  (keys.length == MANDO_FIELDS.length - 1 && !keys.include?("cid"))
end

def valid_byr?(val)
  return false if !val

  year = val.to_i
  year && year >= 1920 && year <= 2002
end

def valid_iyr?(val)
  return false if !val

  year = val.to_i
  year && year >= 2010 && year <= 2020
end

def valid_eyr?(val)
  return false if !val

  year = val.to_i
  year && year >= 2020 && year <= 2030
end

def valid_hgt?(val)
  return false if !val

  if val.include?("cm")
    hgt = val.gsub("cm", "").to_i
    return hgt && hgt >= 150 && hgt <= 193
  elsif val.include?("in")
    hgt = val.gsub("in", "").to_i
    return hgt && hgt >= 59 && hgt <= 76
  end

  false
end

def valid_hcl?(val)
  return false if !val

  val.match?(HCL_REGEX)
end

def valid_ecl?(val)
  return false if !val

  VALID_ECL.include?(val)
end

def valid_pid?(val)
  return false if !val

  val.match?(PID_REGEX)
end

def is_passport_valid?(passport)
  str_fields = passport.split(" ")
  fields = str_fields.reduce({}) { |fields, str| parts = str.split(":").map(&:strip); fields[parts[0]] = parts[1]; fields }

  # puts fields
  # puts "  byr: #{valid_byr?(fields["byr"])}"
  # puts "  iyr: #{valid_iyr?(fields["iyr"])}"
  # puts "  eyr: #{valid_eyr?(fields["eyr"])}"
  # puts "  hgt: #{valid_hgt?(fields["hgt"])}"
  # puts "  hcl: #{valid_hcl?(fields["hcl"])}"
  # puts "  ecl: #{valid_ecl?(fields["ecl"])}"
  # puts "  pid: #{valid_pid?(fields["pid"])}"

  required_fields_present?(fields) &&
  valid_byr?(fields["byr"]) &&
  valid_iyr?(fields["iyr"]) &&
  valid_eyr?(fields["eyr"]) &&
  valid_hgt?(fields["hgt"]) &&
  valid_hcl?(fields["hcl"]) &&
  valid_ecl?(fields["ecl"]) &&
  valid_pid?(fields["pid"])
end

answer = passports.reduce(0) { |sum, passport| sum += 1 if is_passport_valid?(passport); sum }
puts "answer: #{answer}"
