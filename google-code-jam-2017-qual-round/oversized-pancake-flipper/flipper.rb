#!/usr/bin/env ruby

require('./pancake_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift
  inputs = line.split(" ")
  value = PancakeSolver.new.solve(inputs[0], inputs[1].to_i)
  puts "Case \##{index + 1}: #{value}"
end
