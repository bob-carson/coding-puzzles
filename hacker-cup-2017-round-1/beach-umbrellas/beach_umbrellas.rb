#!/usr/bin/env ruby

require './umbrella_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ").map(&:to_i)
  radii = []
  input[0].times do |_j|
    radii << lines.shift.to_i
  end
  value = UmbrellaSolver.solve(input[1], radii)
  puts "Case \##{index + 1}: #{value}"
end
