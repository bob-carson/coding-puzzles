#!/usr/bin/env ruby

class Solver
  def solve(n, c)
    return "IMPOSSIBLE" if c < n - 1
    return "IMPOSSIBLE" if c > _max_cost_for_n(n)
    # puts "sequence #{_cost_sequence(n,c)}"
    cost_sequence = _cost_sequence(n,c)
    list = (1..n).to_a

    cost_sequence.each_with_index do |cost, index|
      i = list.length - 2 - index
      j = i + cost - 1
      list[i..j] = list[i..j].reverse
    end

    list.join(" ")
  end

  def _cost_sequence(n, c)
    cost = n - 1
    sequence = Array.new(n - 1, 1)

    i = 0
    while cost < c
      max_value = i + 2
      if cost + max_value - 1 < c
        sequence[i] = max_value
        cost += max_value - 1
        i += 1
      else
        sequence[i] = c - cost + 1
        break
      end
    end

    sequence
  end

  def _max_cost_for_n(n)
    (n * (n + 1) / 2) - 1
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  out = Solver.new.solve(inputs[0], inputs[1])
  puts "Case \##{index + 1}: #{out}"
end
