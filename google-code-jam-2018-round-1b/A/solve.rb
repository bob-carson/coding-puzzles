#!/usr/bin/env ruby
require 'bigdecimal'

class Solver
  def solve(n, l, list)

    inf = n + 1

    diffs = list_diffs(n)
    max_diff = diffs.max
    min_diff = diffs.min

    return "100" if max_diff == min_diff

    already_surveyed = list.inject(0) do |l, sum|
      l + sum
    end

      left_to_survey = n - already_surveyed

      list += Array.new(left_to_survey) { 0 }
      l += left_to_survey

    distance_from_max = (0..n).map do |i|
      j = 0
      while j < n && diffs[i + j] != max_diff
        j += 1
      end
      if diffs[i + j] == max_diff
        j
      else
        inf
      end
    end



#puts "left_to_survey #{left_to_survey}"
    while left_to_survey > 0
      distance_left = list.map { |x| distance_from_max[x] }
      min_distance = distance_left.min
      # puts "min_distance #{min_distance}"
      min_index = distance_left.index(min_distance)
      # puts "min_index #{min_index}"
      # puts "list #{list}"
      list[min_index] += 1
      left_to_survey -= 1
    end

    # #puts "diffs #{diffs} distance_from_max #{distance_from_max}"

    # #puts "already_surveyed #{already_surveyed}"
    # #puts "max_diff #{max_diff} min_diff #{min_diff}"

    # list.map(&:to_i)]
    # puts "list #{list}"

    percents = list.map do |x|
      (x * 100.0/n).round
    end

    # puts "percents #{percents}"

    percents.inject(0) { |x, s| x+s }
  end

  def list_diffs(n)
    percents = list_percents(n)
    (1..n).map do |i|
      percents[i] - percents[i-1]
    end
  end

  def list_percents(n)
    (0..n).map do |x|
      (x * 100.0/n).round
    end
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  list = lines.shift.split(" ").map(&:to_i)
  value = Solver.new.solve(inputs[0], inputs[1], list)
  puts "Case \##{index + 1}: #{value}"
end
