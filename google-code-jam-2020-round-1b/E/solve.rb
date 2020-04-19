#!/usr/bin/env ruby

class Solver
  def solve(array)
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  array = lines.shift.split("").map(&:to_i)
  out = Solver.new.solve(array)
  puts "Case \##{index + 1}: #{out}"
end
