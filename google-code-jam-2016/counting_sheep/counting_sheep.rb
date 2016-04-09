#!/usr/bin/env ruby

require 'set'

def digits(n)
  return Set.new([0]) if n == 0

  digits = Set.new
  while n > 0
    digits.add(n % 10)
    n = n / 10
  end
  digits
end

def count_sheep(n)
  return "INSOMNIA" if n == 0

  i = n
  digits_seen = Set.new()
  while true
    digits_seen = digits_seen.union(digits(i))
    return i if digits_seen.count == 10
    i += n
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  value = count_sheep(n)
  puts "Case \##{index + 1}: #{value}"
end
