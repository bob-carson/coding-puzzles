#!/usr/bin/env ruby

require('./dragon_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift.split(" ").map(&:to_i)

  value = DragonSolver.new.solve(*line)
  puts "Case \##{index + 1}: #{value}"
end
