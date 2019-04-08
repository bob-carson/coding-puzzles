#!/usr/bin/env ruby

class Solver
  def solve(n, path)
    raise "Invalid input length" unless path.length == 2 * n - 2

    output_path = []
    path.each do |direction|
      if direction == "S"
        output_path << "E"
      else
        output_path << "S"
      end
    end

    output_path.join("")
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  path = lines.shift.split("")
  value = Solver.new.solve(n, path)
  puts "Case \##{index + 1}: #{value}"
end
