#!/usr/bin/env ruby

IMPOSSIBLE = "IMPOSSIBLE"

class Solver
  def solve(n, k)
    puts "#{[n, k]}"
    diagonal = _diagonal(n, k)
    return IMPOSSIBLE if diagonal == IMPOSSIBLE
    puts "#{diagonal}"
    _latin_square(diagonal)
  end

  def _latin_square(diagonal)
    n = diagonal.length

    square = Array.new(n) { Array.new(n, nil) }
    order = _placement_order(diagonal)
    puts "order #{order}"
    diagonal.each_with_index do |digit, i|
      square[i][i] = digit
    end

    last_placement = (0...n).to_a
    order.each do |digit|
      (0...n).each do |row|
        next if square[row].include?(digit)
        first_legal_placement = _first_legal_placement(digit, row, square, last_placement)
        square[row][first_legal_placement] = digit
        puts "placing #{digit} at #{row}, #{first_legal_placement}"
        puts "last placement #{last_placement}"
      end
    end

    square
  end

  def _first_legal_placement(digit, row, square, last_placement)
    runner = last_placement[row] + 1
    runner = 0 if runner == square.length

    while runner != last_placement[row]
      if _legal?(digit, row, runner, square)
        last_placement[row] = runner
        return runner
      end
      if runner == square.length - 1
        runner = 0
      else
        runner += 1
      end
    end

    raise "No legal placements digit #{digit} square #{square}"
  end

  def _legal?(digit, row, column, square)
    return false if square[row][column] != nil
    return false if square.any? { |square_row| square_row[column] == digit }
    true
  end

  def _placement_order(diagonal)
    n = diagonal.length

    (1..n).sort_by { |i| diagonal.count(i) }.reverse
  end

  def _diagonal(n, k)
    return IMPOSSIBLE if k < n
    return IMPOSSIBLE if k > n * n
    return IMPOSSIBLE if k == n + 1 || k == n * n - 1
    return IMPOSSIBLE if n == 3 && (k == 5 || k == 7)

    return Array.new(n, k / n) if k % n == 0

    _complex_diag(n, k)
  end

  def _complex_diag(n, k)
    midpoint = ((n + 1) * (n / 2.0)).to_i

    if k <= midpoint
      above_min = k - n
      flex = (n / 2.0).ceil
      diag = Array.new(n, 1)
      runner = n - 1
      while above_min > 0
        diag[runner] += 1
        if runner == n - flex
          runner = n - 1
        else
          runner -= 1
        end
        above_min -= 1
      end
      diag
    else
      below_max = n * n - k
      flex = (n / 2.0).ceil
      diag = Array.new(n, n)
      runner = n - 1
      while below_max > 0
        diag[runner] -= 1
        if runner == n - flex
          runner = n - 1
        else
          runner -= 1
        end
        below_max -= 1
      end
      diag
    end
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ").map(&:to_i)
  out = Solver.new.solve(input[0], input[1])
  puts "Case \##{index + 1}: #{out}"
end
