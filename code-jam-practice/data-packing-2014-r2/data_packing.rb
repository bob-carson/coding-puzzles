#!/usr/bin/env ruby

require './data_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  first_line = lines.shift.split(" ")
  n = first_line[0].to_i
  x = first_line[1].to_i
  sizes = lines.shift.split(" ").map(&:to_i)
  value = DataSolver.solve(x, sizes)
  puts "Case \##{index + 1}: #{value}"
end
