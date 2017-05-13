#!/usr/bin/env ruby

require('./rat_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift.split(" ").map(&:to_i)
  n = line[0]
  # p = line[1]
  required = lines.shift.split(" ").map(&:to_i)
  packages = []
  n.times do
    packages << lines.shift.split(" ").map(&:to_i)
  end

  value = RatSolver.new.solve(required, packages)
  puts "Case \##{index + 1}: #{value}"
end
