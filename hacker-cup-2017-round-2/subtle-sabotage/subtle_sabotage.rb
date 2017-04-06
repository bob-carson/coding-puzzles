#!/usr/bin/env ruby

require './sabotage_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ").map(&:to_i)
  value = SabotageSolver.solve(input[0], input[1], input[2])
  puts "Case \##{index + 1}: #{value}"
end
