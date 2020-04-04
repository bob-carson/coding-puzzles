#!/usr/bin/env ruby

class Solver
  def solve(matrix)
    matrix.to_s
    "#{_trace(matrix)} #{_rows_with_repeats(matrix)} #{_columns_with_repeats(matrix)}"
  end

  def _trace(matrix)
    sum = 0
    (0...matrix.length).each do |i|
      sum += matrix[i][i]
    end
    sum
  end

  def _rows_with_repeats(matrix)
    count = 0
    (0...matrix.length).each do |i|
      if matrix[i].uniq.length < matrix.length
        count += 1
      end
    end
    count
  end

  def _columns_with_repeats(matrix)
    count = 0
    (0...matrix.length).each do |i|
      if _column(i, matrix).uniq.length < matrix.length
        count += 1
      end
    end
    count
  end

  def _column(n, matrix)
    [].tap do |col|
      (0...matrix.length).each do |i|
        col << matrix[i][n]
      end
    end
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  matrix = []
  n.times do
    matrix << lines.shift.split(" ").map(&:to_i)
  end
  out = Solver.new.solve(matrix)
  puts "Case \##{index + 1}: #{out}"
end
