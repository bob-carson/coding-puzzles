#!/usr/bin/env ruby

class Solver
  def solve(fun_factors, points_to)
    modules = (0...fun_factors.count).map do |i|
      [fun_factors[i], points_to[i]]
    end

    initiators = (1..modules.count).to_a
    modules.each do |mod|
      initiators.delete(mod[1])
    end

    min_values = (1..modules.count).map { |_| nil }
    modules.each do |mod|
      next if mod[1] == 0

      if min_values[mod[1] - 1] == nil || min_values[mod[1] - 1] > mod[0]
        min_values[mod[1] - 1] = mod[0]
      end
    end

    [modules, initiators, min_values]
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  fun_factors = lines.shift.split(" ").map(&:to_i)
  points_to = lines.shift.split(" ").map(&:to_i)
  out = Solver.new.solve(fun_factors, points_to)
  puts "Case \##{index + 1}: #{out}"
end
