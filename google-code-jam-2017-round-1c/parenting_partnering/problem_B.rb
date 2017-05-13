#!/usr/bin/env ruby

require('./b_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift.split(" ").map(&:to_i)
  a_c = line[0]
  a_j = line[1]

  cam = []
  a_c.times do
    cam << lines.shift.split(" ").map(&:to_i)
  end

  jam = []
  a_j.times do
    jam << lines.shift.split(" ").map(&:to_i)
  end

  value = BSolver.new.solve(cam, jam)
  puts "Case \##{index + 1}: #{value}"
end
