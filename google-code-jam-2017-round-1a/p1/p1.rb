#!/usr/bin/env ruby

require('./alpha_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  rows = lines.shift.split(" ")[0].to_i
  cake = []
  rows.times do
    cake << lines.shift.split("").map { |c| c == "?" ? nil : c }
  end

  value = AlphaSolver.new.solve(cake)
  puts "Case \##{index + 1}:#{value}"
end
