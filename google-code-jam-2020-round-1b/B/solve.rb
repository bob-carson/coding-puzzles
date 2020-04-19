#!/usr/bin/env ruby

class Solver
  def solve(array)
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.to_i
  value = Solver.new.solve(input)
  puts "Case \##{index + 1}: #{value}"
end
