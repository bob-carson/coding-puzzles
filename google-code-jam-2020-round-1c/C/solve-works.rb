#!/usr/bin/env ruby

require 'benchmark'

class Solver
  def solve(n, d, arr)
    return d - 1 if n == 1

    arr.sort!

    total = arr.inject(0) { |a, e| a + e }

    candidates = []

    time = Benchmark.measure {
      arr.uniq.each do |a|
        (1...d).each do |i|
          next if a * d > total * i
          candidates << [a, i]
        end
      end
    }

        puts "candidate time #{time.real}"

    candidates = candidates.uniq { |c| 1.0 * c[0] / c[1]}

    # puts "candidates #{candidates}"

    tries = nil

    time = Benchmark.measure {
      tries = candidates.map do |slice_size, multiplier|
        _cuts_for_slice_size(slice_size, multiplier, d, arr).tap do |a|
          return 0 if a == 0
        end
      end
    }
        puts "cuts and slices time #{time.real}"

    # puts "tries #{tries}"

    tries.select { |p| p != nil }.min
  end

  def _cuts_for_slice_size(slice_size, multiplier, d, arr)
    # puts "slice_size #{slice_size} d #{d} arr #{arr}"

    pieces_and_cuts = arr.map { |a_i| _pieces_and_cuts(slice_size, a_i * multiplier) }

    pieces_and_cuts.select! { |p| p[1] != nil }

    return nil if pieces_and_cuts.inject(0) { |a, e| a + e[0] } < d

    # puts "pieces_and_cuts #{pieces_and_cuts}"

    save_cuts = pieces_and_cuts.select { |p| p[0] > p[1] }

    served = 0
    cuts = 0
    save_cuts.each do |p|
      if served + p[0] == d
        return cuts + p[1]
      elsif served + p[0] > d
        return cuts + (d - served)
      end
      served += p[0]
      cuts += p[1]
    end

    cuts + (d - served)
  end

  def _pieces_and_cuts(slice_size, a_i)
    return [0, nil] if slice_size > a_i

    slice_size = slice_size * 1.0

    cuts = nil
    if a_i % slice_size == 0
      cuts = (a_i/slice_size - 1).to_i
    else
      cuts = (a_i/slice_size).ceil
    end
    [(a_i/slice_size).floor, cuts]
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  input = lines.shift.split(" ").map(&:to_i)
  n = input[0]
  d = input[1]
  arr = lines.shift.split(" ").map(&:to_i)
  value = Solver.new.solve(n, d, arr)
  puts "Case \##{index + 1}: #{value}"
end
