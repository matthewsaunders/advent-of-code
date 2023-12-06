#!/usr/bin/env ruby

FILENAME = "input.txt"
EMPTY_LINE = "\n"
SECTION_INCREMENT = 2

lines = File.readlines(FILENAME)

seeds = []
$seed_2_soil_map = {}
$soil_2_fert_map = {}
$fert_2_water_map = {}
$water_2_light_map = {}
$light_2_temp_map = {}
$temp_2_hum_map = {}
$hum_2_loc_map = {}

def generate_map(line)
  numbers = line.split(" ").map { |num| Integer(num.strip) }
  dst_start = numbers[1]
  src_start = numbers[0]
  range_length = numbers[2]
  range = (0..range_length).to_a

  map = range.reduce({}) { |map, i| h = {}; h[dst_start + i] = src_start + i; map.merge(h) }
  map
end

def get_map_value(map, index)
  map[index] || index
end

def determine_seed_location(seed)
  soil = get_map_value($seed_2_soil_map, seed)
  fert = get_map_value($soil_2_fert_map, soil)
  water = get_map_value($fert_2_water_map, fert)
  light = get_map_value($water_2_light_map, water)
  temp = get_map_value($light_2_temp_map, light)
  hum = get_map_value($temp_2_hum_map, temp)
  get_map_value($hum_2_loc_map, hum)
end

# parse seeds
seeds = lines[0].sub("seeds: ", "").split(" ").map { |num| Integer(num.strip) }

# parse $seed_2_soil_map
pointer = 3

while lines[pointer] != EMPTY_LINE
  $seed_2_soil_map = $seed_2_soil_map.merge(generate_map(lines[pointer]))
  pointer += 1
end

# parse $soil_2_fert_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $soil_2_fert_map = $soil_2_fert_map.merge(generate_map(lines[pointer]))
  pointer += 1
end

# parse $fert_2_water_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $fert_2_water_map = $fert_2_water_map.merge(generate_map(lines[pointer]))
  pointer += 1
end

# parse $water_2_light_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $water_2_light_map = $water_2_light_map.merge(generate_map(lines[pointer]))
  pointer += 1
end

# parse $light_2_temp_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $light_2_temp_map = $light_2_temp_map.merge(generate_map(lines[pointer]))
  pointer += 1
end

# parse $temp_2_hum_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $temp_2_hum_map = $temp_2_hum_map.merge(generate_map(lines[pointer]))
  pointer += 1
end

# parse $hum_2_loc_map
pointer += SECTION_INCREMENT

while lines[pointer] != nil
  $hum_2_loc_map = $hum_2_loc_map.merge(generate_map(lines[pointer]))
  pointer += 1
end

# find locations
locations = seeds.reduce([]) { |arr, seed| arr << determine_seed_location(seed) }

puts "answer: #{locations.min}"
