#!/usr/bin/env ruby

require './up_and_down_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  sequence = lines.shift.split(" ").first(n).map(&:to_i)
  value = UpAndDownSolver.solve(sequence)
  puts "Case \##{index + 1}: #{value}"
end
