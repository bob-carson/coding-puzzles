#!/usr/bin/env ruby

class Solver
  def solve(array)
    first_chrs = array.map { |r| r[1][0] }
    counts = first_chrs.inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }

    # puts "counts #{counts}"

    non_zero = counts.to_a.sort_by { |c| c[1] }.reverse.map { |a| a[0] }

    zero = nil

    while !zero
      array.each do |a|
        a[1].each do |i|
          if !non_zero.include?(i)
            zero = i
          end
        end
      end
    end

    zero + non_zero.join("")
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  u = lines.shift.to_i
  array = []
  array.tap do |ar|
    10_000.times do
      input = lines.shift.split(" ")
      array << [input[0].to_i, input[1].split("")]
    end
  end
  value = Solver.new.solve(array)
  puts "Case \##{index + 1}: #{value}"
end
