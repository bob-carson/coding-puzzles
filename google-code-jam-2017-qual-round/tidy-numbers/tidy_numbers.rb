#!/usr/bin/env ruby

require('./tidy_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift
  value = TidySolver.new.solve(line)
  puts "Case \##{index + 1}: #{value}"
end
