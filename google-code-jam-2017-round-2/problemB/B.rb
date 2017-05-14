#!/usr/bin/env ruby

require('./b_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift.split(" ").map(&:to_i)
  n = line[0]
  c = line[1]
  m = line[2]
  tickets = []
  m.times do
    tickets << lines.shift.split(" ").map(&:to_i)
  end

  value = BSolver.new.solve(n, c, tickets)
  puts "Case \##{index + 1}: #{value}"
end
