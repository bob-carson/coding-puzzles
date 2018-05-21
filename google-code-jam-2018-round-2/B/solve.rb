#!/usr/bin/env ruby

class Solver
  def solve()

  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  waffle = []
  inputs[0].times do
    waffle << lines.shift.split("")
  end
  value = Solver.new.solve
  puts "Case \##{index + 1}: #{value}"
end
