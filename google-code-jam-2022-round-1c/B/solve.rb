#!/usr/bin/env ruby

require 'bigdecimal'

class Solver
  def solve(k, numbers)
    sum_n = numbers.inject(&:+)
    sum_n2 = numbers.inject(0) { |sum, n| sum + n**2 }

    return "IMPOSSIBLE" if sum_n == 0 && sum_n2 != 0

    # puts "numbers: #{numbers} sum_n: #{sum_n} sum_n2: #{sum_n2}"

    if sum_n2 > sum_n ** 2
      i = Math.sqrt(sum_n2 - sum_n ** 2).floor - 3
      while (sum_n2 + i ** 2) > (sum_n + i) ** 2
        puts "i: #{i} (sum_n2 + i ** 2): #{(sum_n2 + i ** 2)} (sum_n + i) ** 2: #{(sum_n + i) ** 2}"
        i += 1
      end

      return i if (sum_n2 + i ** 2) == (sum_n + i) ** 2
    else
      i = 0
      while (sum_n2 + i ** 2) < (sum_n + i) ** 2
        puts "i: #{i}"
        i -= 1
      end

      return i if (sum_n2 + i ** 2) == (sum_n + i) ** 2
    end
    return "IMPOSSIBLE"
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  first_line = lines.shift.split(" ").map(&:to_i)
  numbers = lines.shift.split(" ").map { |str| BigDecimal.new(str) }
  out = Solver.new.solve(first_line[1], numbers)
  puts "Case \##{index + 1}: #{out}"
end
