#!/usr/bin/env ruby

require './freeform_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  grid = []
  n.times do
    grid << lines.shift.split("").first(n).map(&:to_i)
  end
  value = FreeformSolver.new.solve(grid)
  puts "Case \##{index + 1}: #{value}"
end
