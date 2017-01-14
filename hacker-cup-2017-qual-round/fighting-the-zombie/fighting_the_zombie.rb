#!/usr/bin/env ruby

require './zombie_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  health = inputs[0]
  spells = lines.shift.split(" ")
  value = ZombieSolver.solve(health, spells)
  puts "Case \##{index + 1}: #{value}"
end
