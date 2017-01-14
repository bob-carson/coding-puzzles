#!/usr/bin/env ruby

require './pie_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  value = PieSolver.solve(inputs[0], inputs[1], inputs[2])
  puts "Case \##{index + 1}: #{value}"
end
