#!/usr/bin/env ruby

require './ll_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  number_of_items = lines.shift.to_i
  item_weights = []
  number_of_items.times do |_j|
    item_weights << lines.shift.to_i
  end
  value = LlSolver.solve(item_weights)
  puts "Case \##{index + 1}: #{value}"
end
