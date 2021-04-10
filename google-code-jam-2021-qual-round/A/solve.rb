#!/usr/bin/env ruby

class Solver
  def solve(list)
    cost = 0
    # puts "list #{list}"
    (0..list.length - 2).each do |i|
      j = list.index(list[i..-1].min)
      cost += j - i + 1
      list[i..j] = list[i..j].reverse
      # puts "list #{list} cost #{cost}"
    end

    cost
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  list = lines.shift.split(" ").map(&:to_i)
  out = Solver.new.solve(list)
  puts "Case \##{index + 1}: #{out}"
end
