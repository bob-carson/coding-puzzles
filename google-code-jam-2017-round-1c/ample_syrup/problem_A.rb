#!/usr/bin/env ruby

require('./a_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift.split(" ").map(&:to_i)
  n = line[0]
  k = line[1]
  pankcakes = []
  n.times do
    pankcakes << lines.shift.split(" ").map(&:to_i)
  end

  value = ASolver.new.solve(k, pankcakes)
  puts "Case \##{index + 1}: #{value}"
end
