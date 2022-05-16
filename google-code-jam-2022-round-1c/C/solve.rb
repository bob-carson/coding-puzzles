#!/usr/bin/env ruby

class Solver
  def solve(dice)
    sorted_dice = dice.sort
    unusable_count = 0
    i = 0
    while i < sorted_dice.count
      if sorted_dice[i] < i + 1 - unusable_count
        unusable_count += 1
      end
      i += 1
    end
    sorted_dice.count - unusable_count
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  dice = lines.shift.split(" ").map(&:to_i)
  out = Solver.new.solve(dice)
  puts "Case \##{index + 1}: #{out}"
end
