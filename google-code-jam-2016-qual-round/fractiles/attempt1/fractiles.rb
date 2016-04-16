#!/usr/bin/env ruby

require "./fractile_solver.rb"
require 'benchmark'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  params = lines.shift.split(" ")
  original_length = params[0].to_i
  complexity = params[1].to_i
  column_guesses = params[2].to_i

  value = FractileSolver.solve(original_length, complexity, column_guesses)
  puts "Case \##{index + 1}: #{value}"
end

