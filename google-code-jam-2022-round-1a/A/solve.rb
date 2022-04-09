#!/usr/bin/env ruby

class Solver
  def solve(word)
    groups = []
    word.each_char do |ch|
      if groups.count == 0
        groups << [ch, 1]
      elsif ch == groups.last[0]
        groups.last[1] += 1
      else
        groups << [ch, 1]
      end
    end
    answer = ""

    (0...groups.count-1).each do |i|
      amount = groups[i][1]
      if groups[i][0] < groups[i+1][0]
        amount *= 2
      end
      amount.times do
        answer += groups[i][0]
      end
    end
    groups.last[1].times do
      answer += groups.last[0]
    end

    answer
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  line = lines.shift
  out = Solver.new.solve(line)
  puts "Case \##{index + 1}: #{out}"
end
