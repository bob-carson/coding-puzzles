#!/usr/bin/env ruby

class Solver
  def solve(students)
    q = students[0][0].length

    candidates = []
    students.each do |s|
      candidates << s
      candidates << [reverse_answers(s[0]), q - s[1]]
    end

    best = candidates.max_by { |x| x[1] }

    "#{best[0]} #{best[1]}/1"
  end

  def reverse_answers(answers)
    letters = answers.split("")
    reversed = []
    letters.each do |l|
      case l
      when "T"
        reversed << "F"
      when "F"
        reversed << "T"
      else
        raise "invalid letter #{l}"
      end
    end
    reversed.join("")
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.split(" ").map(&:to_i)[0]
  students = []
  n.times do
    students << lines.shift.split(" ")
    students.last[1] = students.last[1].to_i
  end
  out = Solver.new.solve(students)
  puts "Case \##{index + 1}: #{out}"
end
