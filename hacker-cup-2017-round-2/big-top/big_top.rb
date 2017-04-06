#!/usr/bin/env ruby

require './big_top_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  x_values = lines.shift.split(" ").map(&:to_i)
  h_values = lines.shift.split(" ").map(&:to_i)
  value = BigTopSolver.solve(n, x_values, h_values)
  puts "Case \##{index + 1}: #{value}"
end
