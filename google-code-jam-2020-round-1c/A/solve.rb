#!/usr/bin/env ruby

class Solver
  def solve(x, y, m)
    time = 0

    current_x = x
    current_y = y

    m.each do |step|
      # puts "current_x #{current_x} current_y #{current_y} next step #{step}"
      if _min_steps(current_x, current_y) <= time
        return time
      end

      if step.start_with?("N")
        current_y += 1
      elsif step.start_with?("S")
        current_y -= 1
      elsif step.start_with?("E")
        current_x += 1
      elsif step.start_with?("W")
        current_x -= 1
      end

      time += 1
    end

    if _min_steps(current_x, current_y) <= time
      return time
    end

    "IMPOSSIBLE"
  end

  def _min_steps(x,y)
    x.abs + y.abs
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ")
  value = Solver.new.solve(input[0].to_i, input[1].to_i, input[2].split(""))
  puts "Case \##{index + 1}: #{value}"
end
