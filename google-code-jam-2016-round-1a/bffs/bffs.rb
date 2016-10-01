#!/usr/bin/env ruby

require "./bff_solver.rb"

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  kids = lines.shift.split(" ").map(&:to_i)
  value = BffSolver.new.solve(kids)
  puts "Case \##{index + 1}: #{value}"
end
