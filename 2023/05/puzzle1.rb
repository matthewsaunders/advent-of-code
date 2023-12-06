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
      src_end: src_start + range_length,
      dst_start: dst_start,
      range_length: range_length,
    }
  end

  def map_value(value)
    @ranges.each do |range|
      if value >= range[:src_start] && value <= range[:src_end]
        return range[:dst_start] + (value - range[:src_start])
      end
    end

    value
  end
end

lines = File.readlines(FILENAME)

seeds = []
$seed_2_soil_map = ValuesMap.new()
$soil_2_fert_map = ValuesMap.new()
$fert_2_water_map = ValuesMap.new()
$water_2_light_map = ValuesMap.new()
$light_2_temp_map = ValuesMap.new()
$temp_2_hum_map = ValuesMap.new()
$hum_2_loc_map = ValuesMap.new()

def determine_seed_location(seed)
  soil = $seed_2_soil_map.map_value(seed)
  fert = $soil_2_fert_map.map_value(soil)
  water = $fert_2_water_map.map_value(fert)
  light = $water_2_light_map.map_value(water)
  temp = $light_2_temp_map.map_value(light)
  hum = $temp_2_hum_map.map_value(temp)
  $hum_2_loc_map.map_value(hum)
end

# parse seeds
seeds = lines[0].sub("seeds: ", "").split(" ").map { |num| Integer(num.strip) }

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

# find locations
locations = seeds.reduce([]) { |arr, seed| arr << determine_seed_location(seed) }

puts "answer: #{locations.min}"
