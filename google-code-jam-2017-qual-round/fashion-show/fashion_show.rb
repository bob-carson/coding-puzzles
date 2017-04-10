#!/usr/bin/env ruby

require('./fashion_solver.rb')

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift
  inputs = line.split(" ")
  models = []
  inputs[1].to_i.times do
    model = lines.shift.split(" ")
    model[1] = model[1].to_i
    model[2] = model[2].to_i
    models << model
  end
  value = FashionSolver.new.solve(inputs[0].to_i, models)
  puts "Case \##{index + 1}: #{value}"
end
