#!/usr/bin/env ruby

FILENAME = "input.txt"
START_NODE = 'AAA'
END_NODE = 'ZZZ'

lines = File.readlines(FILENAME)

directions = lines[0].strip.split("")
$graph = {}

def add_line_to_graph(line)
  parts = line.split(" = ")

  node = parts[0]
  edges = parts[1].gsub("(", "").gsub(")", "").split(",").map(&:strip)

  $graph[node] = edges
end

# Parse graph
(2..lines.length-1).to_a.each do |index|
  add_line_to_graph(lines[index])
end

# Navigate through graph until we find ZZZ
current = START_NODE
count = 0

while current != END_NODE
  step = directions[count % directions.length]
  current = step == 'L' ? $graph[current][0] : $graph[current][1]
  count += 1
end

puts "answer: #{count}"
