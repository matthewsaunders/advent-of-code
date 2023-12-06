#!/usr/bin/env ruby

FILENAME = "input.txt"
EMPTY_LINE = "\n"
SECTION_INCREMENT = 2

class ValuesMap
  def initialize
    @ranges = []
  end

  def add_range(str)
    numbers = str.split(" ").map { |num| Integer(num.strip) }
    dst_start = numbers[0]
    src_start = numbers[1]
    range_length = numbers[2]
    @ranges << self.generate_range_obj(dst_start, src_start, range_length)
  end

  def generate_range_obj(dst_start, src_start, range_length)
    {
      src_start: src_start,
      dst_start: dst_start,
      dst_end: dst_start + range_length,
      range_length: range_length,
    }
  end

  def reverse_map_value(value)
    @ranges.each do |range|
      if value >= range[:dst_start] && value <= range[:dst_end]
        return range[:src_start] + (value - range[:dst_start])
      end
    end

    value
  end
end

lines = File.readlines(FILENAME)

$seeds = []
$seed_2_soil_map = ValuesMap.new()
$soil_2_fert_map = ValuesMap.new()
$fert_2_water_map = ValuesMap.new()
$water_2_light_map = ValuesMap.new()
$light_2_temp_map = ValuesMap.new()
$temp_2_hum_map = ValuesMap.new()
$hum_2_loc_map = ValuesMap.new()

def determine_location_seed(loc)
  hum = $hum_2_loc_map.reverse_map_value(loc)
  temp = $temp_2_hum_map.reverse_map_value(hum)
  light = $light_2_temp_map.reverse_map_value(temp)
  water = $water_2_light_map.reverse_map_value(light)
  fert = $fert_2_water_map.reverse_map_value(water)
  soil = $soil_2_fert_map.reverse_map_value(fert)
  $seed_2_soil_map.reverse_map_value(soil)
end

def is_seed_in_seeds?(seed)
  $seeds.each do |seed_range|
    if seed >= seed_range[:start] && seed <= seed_range[:end]
      return true
    end
  end

  false
end

# parse seeds
seed_ranges = lines[0].sub("seeds: ", "").split(" ").map { |num| Integer(num.strip) }

seed_ranges.each_slice(2) do |start, count|
  $seeds << {
    start: start,
    end: start + count,
  }
end

# parse $seed_2_soil_map
pointer = 3

while lines[pointer] != EMPTY_LINE
  $seed_2_soil_map.add_range(lines[pointer])
  pointer += 1
end

# parse $soil_2_fert_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $soil_2_fert_map.add_range(lines[pointer])
  pointer += 1
end

# parse $fert_2_water_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $fert_2_water_map.add_range(lines[pointer])
  pointer += 1
end

# parse $water_2_light_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $water_2_light_map.add_range(lines[pointer])
  pointer += 1
end

# parse $light_2_temp_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $light_2_temp_map.add_range(lines[pointer])
  pointer += 1
end

# parse $temp_2_hum_map
pointer += SECTION_INCREMENT

while lines[pointer] != EMPTY_LINE
  $temp_2_hum_map.add_range(lines[pointer])
  pointer += 1
end

# parse $hum_2_loc_map
pointer += SECTION_INCREMENT

while lines[pointer] != nil
  $hum_2_loc_map.add_range(lines[pointer])
  pointer += 1
end

# find closest seed
found_seed = false
location = 0

while !found_seed
  seed = determine_location_seed(location)

  if is_seed_in_seeds?(seed)
    found_seed = true
  else
    location += 1
  end

  if location % 1000000 == 0
    puts "..location: #{location}, seed: #{seed}, #{found_seed}"
  end
end

puts "answer: #{location}"
