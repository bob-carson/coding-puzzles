#!/usr/bin/env ruby

class Solver
  def solve(l_in, r_in)
    diff = (l_in - r_in).abs

    l = l_in
    r = r_in

    n = _n_to_equalize(diff)

    puts "l #{l_in} r #{r_in} diff #{diff} n to eq #{n} one stack #{_one_stack_n(n)}"
    if l >= r
      l -= _one_stack_n(n)
    else
      r -= _one_stack_n(n)
    end

    puts "new l #{l} new r #{r} n #{n}"

    puts "big stack m #{_big_stack_m(n, [l, r].max)}"

    big_stack_m = _big_stack_m(n, [l, r].max)
    little_stack_m = _little_stack_m(n, big_stack_m, [l, r].min)

    if l >= r
      l -= _pancakes_in_stack(n + 1, big_stack_m)
      r -= _pancakes_in_stack(n + 2, little_stack_m)
    else
      r -= _pancakes_in_stack(n + 1, big_stack_m)
      l -= _pancakes_in_stack(n + 2, little_stack_m)
    end

    n = [n+1+big_stack_m, n+2+little_stack_m].max

    "#{n} #{l} #{r}"
  end

  def _little_stack_m(n, big_m, little_stack)
    if _pancakes_in_stack(n+2, big_m) > little_stack
      big_m
    else
      big_m - 2
    end
  end

  def _big_stack_m(n, b_stack)
    # ((-1 * (n + 1) + Math.sqrt((n + 1) ** 2 + 4 * b)) / 2).floor * 2
    # (-1 * (n + 2) + Math.sqrt((n+2) ** 2 + (b - n - 1))) #.floor
    f = n + 1
    b_const = f + 1
    (-1 * (b_const / 2.0) + 0.5 * Math.sqrt(b_const ** 2 + 4 * (b_stack - f))).floor
  end

  def _pancakes_in_stack(f, m)
    (f + m) * (m + 1)
  end

  def _n_to_equalize(diff)
    (-0.5 + Math.sqrt(0.25 + 2 * diff)).ceil
  end

  def _one_stack_n(n)
    ((1 + n) * n) / 2
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ")
  value = Solver.new.solve(input[0].to_i, input[1].to_i)
  puts "Case \##{index + 1}: #{value}"
end
