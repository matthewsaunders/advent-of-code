#!/usr/bin/env ruby

FILENAME = "input.txt"

def parse_num_array(str)
  str.split(" ").map(&:strip)
end

def game_card_points(card)
  parts = card.split("|")

  winning_numbers = parse_num_array(parts[0])
  given_numbers = parse_num_array(parts[1])
  points = 0

  given_numbers.each do |num|
    next unless winning_numbers.include?(num)

    points = points == 0 ? 1 : points * 2
  end

  puts "..points: #{points}"
  points
end

class Card
  def initialize(index, numbers)
    parts = numbers.split("|")
    @index = index + 1
    @winning_numbers = parse_num_array(parts[0])
    @given_numbers = parse_num_array(parts[1])
  end

  def index
    @index
  end

  def num_winning_numbers
    @given_numbers.reduce(0) { |total, number| @winning_numbers.include?(number) ? total + 1 : total }
  end

  def print
    puts "Card #{@index}"
    puts "..winning_numbers: #{@winning_numbers.join(", ")}"
    puts "..given_numbers: #{@given_numbers.join(", ")}"
    puts "..num_winning_numbers: #{num_winning_numbers}"
  end
end

lines = File.readlines(FILENAME)
cards = lines.each_with_index.map { |line, index| numbers = line.split(":")[1]; Card.new(index, numbers) }
sum = 0

num_copies = {}
(0..cards.length).to_a.each do |i|
  num_copies[i+1] = 1
end

while cards.length > 0
  card = cards.shift
  sum += num_copies[card.index]
  num_winning_numbers = card.num_winning_numbers

  (1..(num_winning_numbers)).to_a.each do |relative_index|
    num_copies[card.index + relative_index] += (1 * num_copies[card.index])
  end
end

puts "answer: #{sum}"
