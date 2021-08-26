#!/usr/bin/env ruby

class Solver
  def solve(cards_array)
    cards = cards_array.to_h

    candidate_piles = [[cards, {}]]
    equal_piles = []
    equal_values = []
    attempted_piles = []

    while candidate_piles.length > 0
      next_candidate = candidate_piles.shift
      score = score_piles(next_candidate)
      if score[0] == score[1]
        equal_piles << next_candidate
        equal_values << score[0]
        # puts "equal pile found #{next_candidate} #{score[0]}"
      elsif score[0] > score[1]
        next_candidate[0].keys.each do |num|
          potential = [remove_card(num, next_candidate[0].clone), add_card(num, next_candidate[1].clone)]

          # puts "potential #{potential}"

          next if candidate_piles.include?(potential) || attempted_piles.include?(potential) || equal_piles.include?(potential)

          candidate_piles << potential
          # puts "candidate added #{potential} from #{next_candidate[0]} num #{num}"
        end
      else
        attempted_piles << next_candidate
      end

    end

    equal_values.max || 0
  end

  def score_piles(piles)
    [cards_to_array(piles[0]).inject(:+) || 0, cards_to_array(piles[1]).inject(:*) || 0]
  end

  def cards_to_array(cards)
    arr = []
    cards.each do |k,v|
      v.times do
        arr << k
      end
    end
    arr
  end

  def remove_card(num, cards)
    raise "num #{num} not found in cards #{cards}" if cards[num].nil?

    cards[num] -= 1
    if cards[num] == 0
      cards.delete(num)
    end

    cards
  end

  def add_card(num, cards)
    if cards[num]
      cards[num] += 1
    else
      cards[num] = 1
    end

    cards
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  cards = []
  n.times do
    cards << lines.shift.split(" ").map(&:to_i)
  end
  out = Solver.new.solve(cards)
  puts "Case \##{index + 1}: #{out}"
end
