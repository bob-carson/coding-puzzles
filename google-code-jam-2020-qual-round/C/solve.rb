#!/usr/bin/env ruby

class Solver
  def solve(activities)
    activities.sort_by! { |a| a[0] }
    c_indicies = []
    c_end = 0
    j_end = 0

    activities.each do |a|
      if a[0] >= c_end
        c_indicies << a[2]
        c_end = a[1]
      else
        return "IMPOSSIBLE" if a[0] < j_end

        j_end = a[1]
      end
    end

    "".tap do |out|
      (0...activities.length).each do |i|
        if c_indicies.include?(i)
          out << "C"
        else
          out << "J"
        end
      end
    end
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  activities = []
  n.times do |i|
    activities << (lines.shift.split(" ").map(&:to_i) << i)
  end
  out = Solver.new.solve(activities)
  puts "Case \##{index + 1}: #{out}"
end
