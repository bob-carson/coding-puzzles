#!/usr/bin/env ruby

require('./c_solver.rb')
require('bigdecimal')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift.split(" ").map(&:to_i)
  n = line[0]
  k = line[1]
  u = BigDecimal.new(lines.shift)

  p = lines.shift.split(" ").map { |l| BigDecimal.new(l) }

  value = CSolver.new.solve(n, k, u, p)
  puts "Case \##{index + 1}: #{value}"
end
