#!/usr/bin/env ruby

class Solver
  def solve(x, y, m)

  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ")
  value = Solver.new.solve(input[0].to_i, input[1].to_i, input[2].split(""))
  puts "Case \##{index + 1}: #{value}"
end
