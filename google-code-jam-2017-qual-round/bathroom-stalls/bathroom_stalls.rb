#!/usr/bin/env ruby

require('./correct_bathroom_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift
  inputs = line.split(" ")
  value = CorrectBathroomSolver.new.solve(inputs[0].to_i, inputs[1].to_i)
  puts "Case \##{index + 1}: #{value}"
end
