#!/usr/bin/env ruby

class Solver
  def solve(l_in, r_in)
    l = l_in
    r = r_in
    customer = 1

    while _can_serve?(l, r, customer)
      if l >= r
        l -= customer
      else
        r -= customer
      end

      customer += 1
    end

    "#{customer - 1} #{l} #{r}"
  end

  def _can_serve?(l, r, i)
    l >= i || r >= i
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ")
  value = Solver.new.solve(input[0].to_i, input[1].to_i)
  puts "Case \##{index + 1}: #{value}"
end
