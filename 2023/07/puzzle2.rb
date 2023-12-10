#!/usr/bin/env ruby

FILENAME = "input.txt"

HAND_TYPE_RANK = {
  '5K': 7,
  '4K': 6,
  'FH': 5,
  '3K': 4,
  '2P': 3,
  '1P': 2,
  'HC': 1,
}

class Hand
  include Comparable

  def initialize(line)
    parts = line.split(" ")

    @cards = parts[0]
    @wager = parts[1].strip.to_i
    @hand_type = self.determine_hand_type()
  end

  def cards
    @cards
  end

  def wager
    @wager
  end

  def hand_type
    @hand_type
  end

  def determine_hand_type()
    cm = @cards.split('').reduce({}) { |map, card| map[card] = (map[card] || 0) + 1; map }
    values = cm.values.sort.reverse
    best_hand = map_arr_to_hand_type(values)
    num_jokers = cm.delete('J')

    # If there are jokers, find the best hand
    if num_jokers
      values = cm.values.sort.reverse

      (0..values.length - 1).to_a.each do |i|
        temp_values = values.dup
        temp_values[i] += num_jokers
        temp_values = temp_values.sort.reverse
        hand_type = map_arr_to_hand_type(temp_values)


        if HAND_TYPE_RANK[hand_type.to_sym] > HAND_TYPE_RANK[best_hand.to_sym]
          best_hand = hand_type
        end
      end
    end

    best_hand
  end

  def map_arr_to_hand_type(arr)
    if arr == [5]
      return '5K'
    elsif arr == [4, 1]
      return '4K'
    elsif arr == [3, 2]
      return 'FH'
    elsif arr == [3, 1, 1]
      return '3K'
    elsif arr == [2, 2, 1]
      return '2P'
    elsif arr == [2, 1, 1, 1]
      return '1P'
    else # [1, 1, 1, 1, 1]
      return 'HC'
    end
  end

  def hand_type_rank
    HAND_TYPE_RANK[@hand_type.to_sym]
  end

  # Used during secondary comparison of checking card by card for HC. Instead of checking each
  # card, substitute the face card values with strings thatt represent string comparison > or <.
  # If we do this, we can compare the string of the hand once instead of each card.
  def card_str
    # Make J a 0 so it is the weakest card
    @cards.gsub('A', 'Z').gsub('K', 'Y').gsub('Q', 'X').gsub('J', '0').gsub('T', 'U')
  end

  def is_better_hand(other)
    return true if self.hand_type_rank > other.hand_type_rank
    return false if self.hand_type_rank < other.hand_type_rank

    # Move to secondary ranking
    self.card_str > other.card_str ? true : false
  end

  # No 0 return as there must an order
  def <=>(other)
    return 1 if self.hand_type_rank > other.hand_type_rank
    return -1 if self.hand_type_rank < other.hand_type_rank

    # Move to secondary ranking
    self.card_str > other.card_str ? 1 : -1
  end
end

lines = File.readlines(FILENAME)
winnings = 0

hands = lines.map { |line| Hand.new(line) }
hands = hands.sort

hands.each_with_index do |hand, index|
  winnings += hand.wager * (index + 1)
end

puts "answer: #{winnings}"
