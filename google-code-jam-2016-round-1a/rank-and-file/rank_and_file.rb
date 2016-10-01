#!/usr/bin/env ruby

def solve(rows)
  _solve(rows).join(" ")
end

def _solve(rows)
  counts = {}
  rows.each do |row|
    row.each do |h|
      counts[h] ||= 0
      counts[h] += 1
    end
  end
  odd_values = []
  counts.each do |value, count|
    if count.odd?
      odd_values << value
    end
  end
  odd_values.sort
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  rows = []
  (2 * n - 1).times { rows << lines.shift.split(" ").map(&:to_i) }
  value = solve(rows)
  puts "Case \##{index + 1}: #{value}"
end
