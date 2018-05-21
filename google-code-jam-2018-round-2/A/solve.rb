#!/usr/bin/env ruby

class Solver
  def solve(c, b_arr)
    return "IMPOSSIBLE" if b_arr[0] == 0 || b_arr[c - 1] == 0

    to_column = get_to_column(c, b_arr)

    # puts "tp column #{to_column}"

    num_rows = get_num_rows(to_column)

    # puts "num rows #{num_rows}"
#
    result = Array.new(num_rows) { Array.new(c, ".") }

    to_column.each_with_index do |value, index|
      next if value == index

      # puts "value #{value} index #{index}"

      row = num_rows - (value - index).abs - 1

      char = value > index ? '\\' : '/'

      result[row][index] = char
    end

    # puts "result #{result}"

    res_string = num_rows.to_s + "\n" + result.map { |row| row.join("") }.join("\n")

    # [c, b_arr]
    res_string
  end

  def get_num_rows(to_column)
    to_column.each_with_index.map do |value, index|
      (value - index).abs
    end.max + 1
  end

  def get_to_column(c, b_arr_orig)
    b_arr = b_arr_orig.dup

    to_column = Array.new(c)
    counter = 0
    b_runner = 0

    while counter < c
      while b_arr[b_runner] == 0
        b_runner += 1
      end

      b_arr[b_runner] -= 1
      to_column[counter] = b_runner
      counter += 1
    end

    to_column
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  c = lines.shift.to_i
  b_arr = lines.shift.split(" ").map(&:to_i)
  value = Solver.new.solve(c, b_arr)
  puts "Case \##{index + 1}: #{value}"
end
