#!/usr/bin/env ruby

require('./a_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift.split(" ").map(&:to_i)
  n = line[0]
  p = line[1]
  groups = lines.shift.split(" ").map(&:to_i)

  value = ASolver.new.solve(p, groups)
  puts "Case \##{index + 1}: #{value}"
end
