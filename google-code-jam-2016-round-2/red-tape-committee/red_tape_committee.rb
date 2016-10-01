#!/usr/bin/env ruby

require './red_tape_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i


number_of_cases.times do |index|
  line_one = lines.shift.split(" ").first(2).map(&:to_i)
  n = line_one[0]
  k = line_one[1]
  probabilities = lines.shift.split(" ").first(n).map(&:to_f)
  value = RedTapeSolver.new.solve(k, probabilities)
  puts "Case \##{index + 1}: #{value}"
end
