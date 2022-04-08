#!/usr/bin/env ruby

class Solver
  def solve(cartigages)
    min_c = 1000000
    min_m = 1000000
    min_y = 1000000
    min_k = 1000000

    cartigages.each do |cart|
      if cart[0] < min_c
        min_c = cart[0]
      end
      if cart[1] < min_m
        min_m = cart[1]
      end
      if cart[2] < min_y
        min_y = cart[2]
      end
      if cart[3] < min_k
        min_k = cart[3]
      end
    end

    return "IMPOSSIBLE" if min_c + min_m + min_y + min_k < 1000000

    ink_left = 1000000 - min_c
    answer = [min_c, 0, 0, 0]

    if ink_left > 0
      if min_m > ink_left
        answer[1] = ink_left
      else
        answer [1] = min_m
        ink_left -= min_m

        if min_y > ink_left
          answer[2] = ink_left
        else
          answer[2] = min_y
          ink_left -= min_y
          answer[3] = ink_left
        end
      end
    end

    answer.join(" ")
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  cartigages = []
  3.times do |j|
    cartigages << lines.shift.split(" ").map(&:to_i)
  end
  out = Solver.new.solve(cartigages)
  puts "Case \##{index + 1}: #{out}"
end
