#!/usr/bin/env ruby

class Solver
  def solve(array)
    string_arrs = array.map { |s| s.split('') }.map { |a| a.reject { |c| c == '*' } }

    first_string = string_arrs[0]

    # puts "string_arrs #{string_arrs}"

    (1...string_arrs.length).each do |i|
      compare = string_arrs[i]

      # puts "compare #{compare}"

      if compare.length >= first_string.length
        (1..first_string.length).each do |i|
          # puts "comparing at i #{i}: #{first_string[-1 * i]} #{compare[-1 * i]}"
          if first_string[-1 * i] != compare[-1 * i]
            return '*'
          end
        end
        first_string = compare
      else
        (1..compare.length).each do |i|
          # puts "comparing at i #{i}: #{first_string[-1 * i]} #{compare[-1 * i]}"
          if first_string[-1 * i] != compare[-1 * i]
            return '*'
          end
        end
      end
    end



    first_string.join('')
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  array = []
  n.times do
    array << lines.shift
  end
  out = Solver.new.solve(array)
  puts "Case \##{index + 1}: #{out}"
end
