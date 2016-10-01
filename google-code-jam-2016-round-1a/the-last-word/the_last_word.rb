#!/usr/bin/env ruby

def solve(word)
  chars = word.split("")
  result = ""
  chars.each do |c|
    p1 = "#{c}#{result}"
    p2 = "#{result}#{c}"
    result = p1 > p2 ? p1 : p2
  end
  result
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  word = lines.shift
  value = solve(word)
  puts "Case \##{index + 1}: #{value}"
end
