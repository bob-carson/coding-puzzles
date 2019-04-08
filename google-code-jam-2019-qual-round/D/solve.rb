#!/usr/bin/env ruby



class Solver
  def solve(n, b, f)
    STDERR.puts [n, b, f]
    puts "1" * n
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  value = Solver.new.solve(inputs[0], inputs[1], inputs[2])
  puts "Case \##{index + 1}: #{value}"
end
