#!/usr/bin/env ruby

class Solver
  def solve(n)
    a = n
    b = 0

    runner = 0
    digits = _digits(n)
    while runner < digits.count
      if digits[runner] == 4
        change = 10 ** runner
        a -= change
        b += change
      end
      runner += 1
    end

    "#{a} #{b}"
  end

  def _digits(n)
    n.to_s.chars.map(&:to_i).reverse
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.to_i
  value = Solver.new.solve(input)
  puts "Case \##{index + 1}: #{value}"
end
