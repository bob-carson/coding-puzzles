#!/usr/bin/env ruby

class TroubleSolver
  def solve(array)
    evens = []
    odds = []

    array.each_with_index do |e, index|
      if index.even?
        evens << e
      else
        odds << e
      end
    end

    evens.sort!
    odds.sort!

    runner = 0
    while runner < odds.count
      return (2 * runner) if odds[runner] < evens[runner]

      break if runner + 1 == evens.count

      return (2 * runner + 1) if evens[runner + 1] < odds[runner]

      runner += 1
    end

    "OK"
  end
end


lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift
  v_array = lines.shift.split(" ").map(&:to_i)
  value = TroubleSolver.new.solve(v_array)
  puts "Case \##{index + 1}: #{value}"
end
