#!/usr/bin/env ruby

require './zombie_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ").map(&:to_i)
  zombies = []
  input[0].times do |_j|
    zombies << lines.shift.split(" ").map(&:to_i)
  end
  value = ZombieSolver.solve(input[1], zombies)
  puts "Case \##{index + 1}: #{value}"
end
