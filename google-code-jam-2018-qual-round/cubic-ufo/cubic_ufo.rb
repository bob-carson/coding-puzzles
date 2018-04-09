#!/usr/bin/env ruby

class CubicSolver
  def solve(array)
  end
end


lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift
  v_array = lines.shift.to_i
  value = CubicSolver.new.solve(v_array)
  puts "Case \##{index + 1}: #{value}"
end
