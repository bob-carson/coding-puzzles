#!/usr/bin/env ruby

require './r_p_s_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").first(4).map(&:to_i)
  value = RPSSolver.solve(inputs[0], inputs[1], inputs[2], inputs[3])
  puts "Case \##{index + 1}: #{value}"
end
