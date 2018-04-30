#!/usr/bin/env ruby

require 'bigdecimal'

class Solver
  def solve(signs)
    return "1 1" if signs.count == 1

    mn_mapping = signs.map do |sign|
      m = sign[0] + sign[1]
      n = sign[0] - sign[2]
      [m, n]
    end

    runner = 0

    longest = Array.new(signs.length)

    while runner < signs.length
      last_longest = runner == 0 ? 0 : longest[runner - 1]
      longest[runner] = longest_set(runner, last_longest, mn_mapping)
      runner += 1
    end

    # puts "#{mn_mapping}"
    # puts "#{longest}"

    max = longest.max
    max_count = longest.count { |x| x == max }

    "#{max} #{max_count}"
  end

  def longest_set(start, last_longest, mn_mapping)
    # puts "longest_set #{start}"
    n = [2, last_longest - 1].max
    while (start + n) < mn_mapping.length && is_set(start, start + n, mn_mapping)
      n += 1
    end
    n
  end

  def is_set(start, finish, mn_mapping)
    # puts "is_set #{start} #{finish}"
    length = finish - start + 1

    m_values = {}
    n_values = {}

    mn_mapping[start..finish].each do |mn|
      if m_values[mn[0]] == nil
        m_values[mn[0]] = 1
      else
        m_values[mn[0]] += 1
      end
      if n_values[mn[1]] == nil
        n_values[mn[1]] = 1
      else
        n_values[mn[1]] += 1
      end
    end

    m_values.each do |m, m_amount|
      n_values.each do |n, n_amount|
        next unless m_amount + n_amount >= length

        all_match = true

        mn_mapping[start..finish].each do |mn|
          if mn[0] != m && mn[1] != n
            all_match = false
            break
          end
        end

        if all_match
          return true
        end
      end
    end

    return false
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  s = lines.shift.to_i
  signs = []
  s.times do
    signs << lines.shift.split(" ").map { |x| BigDecimal.new(x) }
  end
  value = Solver.new.solve(signs)
  puts "Case \##{index + 1}: #{value}"
end
