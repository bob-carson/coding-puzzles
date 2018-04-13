#!/usr/bin/env ruby

class Solver
  def solve
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift
  inputs = line.split(" ")
  value = Solver.new.solve(inputs[0].to_i, inputs[1])
  puts "Case \##{index + 1}: #{value}"
end
