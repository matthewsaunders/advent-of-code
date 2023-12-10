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

  def determine_hand_type
    # card map
    cm = @cards.split('').reduce({}) { |map, card| map[card] = (map[card] || 0) + 1; map }

    if cm.keys.length == 1
      return '5K'
    elsif cm.keys.length == 2
      if cm.values[0] == 4 || cm.values[1] == 4
        return '4K'
      end

      return 'FH'
    elsif cm.keys.length == 3
      if cm.values[0] == 3 || cm.values[1] == 3 || cm.values[2] == 3
        return '3K'
      end

      return '2P'
    elsif cm.keys.length == 4
      return '1P'
    end

    # If all checks fail, best hand is HC
    'HC'
  end

  def hand_type_rank
    HAND_TYPE_RANK[@hand_type.to_sym]
  end

  # Used during secondary comparison of checking card by card for HC. Instead of checking each
  # card, substitute the face card values with strings thatt represent string comparison > or <.
  # If we do this, we can compare the string of the hand once instead of each card.
  def card_str
    @cards.gsub('A', 'Z').gsub('K', 'Y').gsub('Q', 'X').gsub('J', 'V').gsub('T', 'U')
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

hands = lines.map { |line| Hand.new(line) }
hands = hands.sort

# hands.each do |hand|
#   puts ""
#   puts "#{hand.cards}"
#   puts "..type: #{hand.hand_type}"
# end

winnings = 0

hands.each_with_index do |hand, index|
  winnings += hand.wager * (index + 1)
end

puts "answer: #{winnings}"
