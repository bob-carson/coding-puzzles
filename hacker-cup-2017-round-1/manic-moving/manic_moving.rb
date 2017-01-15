#!/usr/bin/env ruby

require './moving_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ").map(&:to_i)
  paths = []
  input[1].times do |_j|
    paths << lines.shift.split(" ").map(&:to_i)
  end
  families = []
  input[2].times do |_j|
    families << lines.shift.split(" ").map(&:to_i)
  end
  value = MovingSolver.new.solve(input[0], paths, families)
  puts "Case \##{index + 1}: #{value}"
end
