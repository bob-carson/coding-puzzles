#!/usr/bin/env ruby
require 'bigdecimal'
class Solver
  def solve(n)
    row = 1

    answer = [[1, 1]]

    amount_left = n - 1
    while amount_left > 0
      row = answer[-1][0]
      if amount_left >= (2 ** row) && (2 ** row) > amount_left / 4
        _add_entire_row(answer)
        amount_left -= (2 ** row)
      elsif amount_left >= ((row + 1) * 2) + 1
        _add_two_smalls(answer)
        amount_left -= ((row + 1) * 2) + 1
      else
        # puts "adding endpoint #{row}"
        _add_endpoint(answer)
        amount_left -= 1
      end
      # puts "amount_left #{amount_left}"
    end

    # _check_answer(answer)

    raise "too many steps #{answer.length} #{answer}" if answer.length > 500

    "\n" + answer.map { |a| a.join(" ") }.join("\n")
  end

  def _check_answer(answer)
    sum = 0
    answer.each do |a|
      sum +=_pascal(a[0], a[1])
    end

    puts "sum #{sum}"
  end

  def _add_endpoint(answer)
    last_row = answer[-1][0]
    if answer[-1][1] == 1
      answer << [last_row + 1, 1]
    else
      answer << [last_row + 1, last_row + 1]
    end
  end

  def _add_two_smalls(answer)
    last_row = answer[-1][0]
    if answer[-1][1] == 1
      answer << [last_row + 1, 1]
      answer << [last_row + 1, 2]
      answer << [last_row + 2, 2]
      answer << [last_row + 2, 1]
    else
      answer << [last_row + 1, last_row + 1]
      answer << [last_row + 1, last_row]
      answer << [last_row + 2, last_row + 1]
      answer << [last_row + 2, last_row + 2]
    end
  end

  def _add_entire_row(answer)
    last_row = answer[-1][0]
    if answer[-1][1] == 1
      (1..(last_row + 1)).each do |i|
        answer << [last_row + 1, i]
      end
    else
      (last_row + 1).downto(1).each do |i|
        answer << [last_row + 1, i]
      end
    end
  end

  # def _smallest_row_larger(n)
  #   Math.log2(n).ceil + 1
  # end

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
