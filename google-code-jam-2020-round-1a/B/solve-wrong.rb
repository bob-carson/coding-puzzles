#!/usr/bin/env ruby
require 'bigdecimal'
class Solver
  def solve(n)
    # puts "n #{n}"

    first_row = _smallest_row_larger(n)
    first_row_count = 2 ** (first_row - 1)
    start_pos = 1
    # puts "first_row_count #{first_row_count} start_pos #{start_pos}"
    while first_row_count > n
      first_row_count -= _pascal(first_row, start_pos)
      start_pos += 1
      # puts "first_row_count #{first_row_count} start_pos #{start_pos}"
    end

    answer = []
    (first_row - start_pos + 1).downto(1).each do |i|
      answer << [first_row, i]
    end

    extra = n - first_row_count

    last_row = answer[-1][0]

    while extra > 0.001
      # puts "extra #{extra}"
      if extra >= 2 ** (last_row - 2)
        # puts "adding row #{last_row - 1} for #{2 ** (last_row - 2)}"
        _add_entire_row!(answer)
        extra -= 2 ** (last_row - 2)
      else
        # puts "adding endpoint #{last_row - 1}"
        _add_endpoint(answer)
        extra -= 1
      end

      last_row = answer[-1][0]
    end

    # _check_answer(answer)

    raise "too many steps" if answer.length > 500

    "\n" + answer.map { |a| a.join(" ") }.join("\n")
  end

  def _check_answer(answer)
    sum = 0
    answer.each do |a|
      sum +=_pascal(a[0], a[1])
    end

    # puts "sum #{sum}"
  end

  def _add_endpoint(answer)
    last_row = answer[-1][0]
    if answer[-1][1] == 1
      answer << [last_row - 1, 1]
    else
      answer << [last_row - 1, last_row - 1]
    end
  end

  def _add_entire_row!(answer)
    last_row = answer[-1][0]
    if answer[-1][1] == 1
      (1..(last_row - 1)).each do |i|
        answer << [last_row - 1, i]
      end
    else
      (last_row - 1).downto(1).each do |i|
        answer << [last_row - 1, i]
      end
    end
  end

  def _smallest_row_larger(n)
    Math.log2(n).ceil + 1
  end

  def _pascal(r, k)
    return 1 if r == 1 || r == k
    _facortial(r - 1) / (_facortial(k - 1) * _facortial(r - k))
  end

  def _facortial(n)
    Math.gamma(n + 1)
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = BigDecimal.new(lines.shift)
  out = Solver.new.solve(n)
  puts "Case \##{index + 1}: #{out}"
end
