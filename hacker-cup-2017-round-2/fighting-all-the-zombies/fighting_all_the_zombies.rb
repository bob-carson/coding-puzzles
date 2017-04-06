#!/usr/bin/env ruby

require './zombie_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ").map(&:to_i)
  w_values = lines.shift.split(" ").map(&:to_i)
  d_values = lines.shift.split(" ").map(&:to_i)
  s_values = lines.shift.split(" ").map(&:to_i)
  value = ZombieSolver.solve(input[0], input[1], w_values, d_values, s_values)
  puts "Case \##{index + 1}: #{value}"
end
