#!/usr/bin/env ruby

require './pie_solver.rb'

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ").map(&:to_i)
  pies_by_day = []
  input[0].times do |_j|
    pies_by_day << lines.shift.split(" ").map(&:to_i)
  end
  value = PieSolver.solve(pies_by_day)
  puts "Case \##{index + 1}: #{value}"
end
