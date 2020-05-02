#!/usr/bin/env ruby

class Solver
  def solve(input)
    factors = input.map { |i| _simplest_positivie(i) }
    while factors[0].length < factors[1].length
      factors[0] << 0
    end
    while factors[1].length < factors[0].length
      factors[1] << 0
    end
    factors[0] << 0
    factors[0] << 0
    factors[1] << 0
    factors[1] << 0

    used = _used(factors)

    return "IMPOSSIBLE" unless _solvable?(used)

    while !_solved?(used)
      first_fix = used.index { |i| i != 1 }
      if used[first_fix] == 0
        _flip_and_add_opposite!(factors, used, first_fix - 1)
        used = _used(factors)
      else
        raise "Unexpected value #{used[first_fix]}" if used[first_fix] != 2
        _flip_and_remove_opposite!(factors, used, first_fix - 1)
        used = _used(factors)
      end
    end

    # return factors

    if input[0] < 0
      factors[0] = factors[0].map { |i| i * -1 }
    end

    if input[1] < 0
      factors[1] = factors[1].map { |i| i * -1 }
    end


    answer = []
    runner = 0
    while runner < factors[0].length
      if factors[0][runner] == 1
        answer << "E"
      elsif factors[0][runner] == -1
        answer << "W"
      elsif factors[1][runner] == 1
        answer << "N"
      elsif factors[1][runner] == -1
        answer << "S"
      end
      runner += 1
    end

    answer.join("")
  end

  def _flip_and_remove_opposite!(factors, used, index)
    # puts "_flip_and_remove_opposite #{index}, #{factors}, #{used}"
    if factors[0][index] != 0
      factors[0][index] = -1 * factors[0][index]
      next_index = index + 1
      while factors[0][next_index] == 1
        factors[0][next_index] = 0
        next_index += 1
      end
      raise "Expected 0 #{factors[0][next_index]}" unless factors[0][next_index] == 0
      factors[0][next_index] = -1 * factors[0][index]
    else
      raise "Expected non-zero #{factors[1][index]}" unless factors[1][index] != 0
      factors[1][index] = -1 * factors[1][index]
      next_index = index + 1
      while factors[1][next_index] == 1
        factors[1][next_index] = 0
        next_index += 1
      end
      raise "Expected 0 got #{factors[1][next_index]}" unless factors[1][next_index] == 0
      factors[1][next_index] = -1 * factors[1][index]
    end
  end

  def _flip_and_add_opposite!(factors, used, index)
    # puts "_flip_and_add_opposite #{index}, #{factors}, #{used}"
    if factors[0][index] != 0
      factors[0][index] = -1 * factors[0][index]
      factors[0][index + 1] = -1 * factors[0][index]
    else
      raise "Expected non-zero #{factors[1][index]}" unless factors[1][index] != 0
      factors[1][index] = -1 * factors[1][index]
      factors[1][index + 1] = -1 * factors[1][index]
    end
  end

  def _used(factors)
    used = []
    factors[0].each_with_index do |element, index|
      used[index] = factors[0][index].abs + factors[1][index].abs
    end
    used
  end

  def _solved?(used)
    runner = 0
    seen_zero = false
    while runner < used.length
      if (used[runner] == 1 && seen_zero) || used[runner] == 2
        return false
      end
      if used[runner] != 1
        seen_zero = true
      end
      runner += 1
    end

    true
  end

  def _solvable?(used)
    used[0] == 1
  end

  def _simplest_positivie(n)
    return [] if n == 0

    left = n.abs
    exp = Math.log2(left).floor
    answer = []
    while exp >= 0
      raise "Expected positive left #{left}" if left < 0
      power = 2 ** exp
        # puts "left #{left} exp #{exp} power #{power} answer #{answer}"
      if power <= left
        left -= power
        answer << 1
      else
        answer << 0
      end
      exp -= 1
    end
    answer.reverse
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ").map(&:to_i)
  value = Solver.new.solve(input)
  puts "Case \##{index + 1}: #{value}"
end
# 100.times { puts "#{rand(-100..100)} #{rand(-100..100)}" }
