#!/usr/bin/env ruby

require "./technobabble_solver.rb"

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  topics = n.times.map do |_|
    lines.shift.split(" ")
  end
  value = TechnoBabbleSolver.new(topics).solve
  puts "Case \##{index + 1}: #{value}"
end
