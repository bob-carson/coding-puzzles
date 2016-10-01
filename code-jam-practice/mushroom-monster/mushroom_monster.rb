#!/usr/bin/env ruby

require 'set'

require "./mushroom_solver.rb"

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  case_length = lines.shift.to_i
  mushrooms = lines.shift.split(" ").map(&:to_i)
  value = MushroomSolver.solve(mushrooms)
  puts "Case \##{index + 1}: #{value}"
end
