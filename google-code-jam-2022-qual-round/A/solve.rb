#!/usr/bin/env ruby

class Solver
  def solve(r, c)
    art = "\n"
    r_counter = 0
    while r_counter < r
      first_line = ""
      second_line = ""
      c_counter = 0
      while c_counter < c
        if c_counter == 0 && r_counter == 0
          first_line << ".."
          second_line << ".."
        else
          first_line << "+-"
          second_line << "|."
        end
        c_counter += 1
      end
      first_line << "+"
      second_line << "|"
      art << first_line + "\n" + second_line + "\n"
      r_counter += 1
    end
    last_line = "+"
    c_counter = 0
    while c_counter < c
      last_line << "-+"
      c_counter += 1
    end
    art << last_line + "\n"

    art
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift.split(" ").map(&:to_i)
  out = Solver.new.solve(line[0], line[1])
  puts "Case \##{index + 1}: #{out}"
end
