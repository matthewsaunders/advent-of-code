#!/usr/bin/env ruby

FILENAME = "input.txt"
START_NODE_CHAR = 'A'
END_NODE_CHAR = 'Z'

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
nodes = $graph.keys.filter { |n| n[-1] == START_NODE_CHAR }
count = 0
least_num_steps = []
nodes.length.times { least_num_steps << 0 }

while least_num_steps.any?(0)
  step = directions[count % directions.length]
  new_nodes = []

  nodes.each_with_index do |current_node, index|
    next_node = current = step == 'L' ? $graph[current_node][0] : $graph[current_node][1]
    new_nodes << next_node

    if next_node[-1] == END_NODE_CHAR && least_num_steps[index] == 0
      least_num_steps[index] = count + 1
    end
  end

  nodes = new_nodes
  count += 1
end

lcm = least_num_steps.reduce(1) { |acc, n| acc.lcm(n) }

puts "answer: #{lcm}"
