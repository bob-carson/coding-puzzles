#!/usr/bin/env ruby

class Solver
  def solve(array)
    return "(" * array[0] + array[0].to_s + ")"* array[0] if array.length == 1

    "".tap do |out|
      out << "(" * array[0] + array[0].to_s

      current_depth = array[0]

      array[1..-1].each do |dig|
        if current_depth < dig
          out << "(" * (dig - current_depth) + dig.to_s
        elsif current_depth > dig
          out << ")" * (current_depth - dig) + dig.to_s
        else
          out << dig.to_s
        end
        current_depth = dig
      end

      out << ")" * array[-1]
    end
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  array = lines.shift.split("").map(&:to_i)
  out = Solver.new.solve(array)
  puts "Case \##{index + 1}: #{out}"
end
