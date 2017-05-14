#!/usr/bin/env ruby

require('./c_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift.split(" ").map(&:to_i)
  r = line[0]
  c = line[1]
  grid = []
  r.times do
    grid << lines.shift.split("")
  end

  value = CSolver.new.solve(grid)
  puts "Case \##{index + 1}: #{value}"
end
