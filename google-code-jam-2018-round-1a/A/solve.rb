#!/usr/bin/env ruby

class Solver
  def solve(r, c, h, v, waffle)
    customers = (h + 1) * (v + 1)

    total_chips = 0
    waffle.each do |row|
      row.each do |c|
        total_chips += 1 if c == "@"
      end
    end

    return "IMPOSSIBLE" unless total_chips % customers == 0

    chips_per_h_cut = total_chips / (h + 1)

    cuts = 0
    chips_left = chips_per_h_cut
    runner = 0

    h_cuts = []

    while cuts < h + 1
      while chips_left > 0
        waffle[runner].each do |c|
          chips_left -= 1 if c == "@"
        end
        runner += 1
      end

      return "IMPOSSIBLE" unless chips_left == 0

      cuts += 1
      chips_left = chips_per_h_cut
      h_cuts << runner unless cuts == h + 1
    end

    chips_per_v_cut = total_chips / (v + 1)

    cuts = 0
    chips_left = chips_per_v_cut
    runner = 0

    v_cuts = []

    while cuts < v + 1
      while chips_left > 0
        (0...waffle.count).each do |n|
          chips_left -= 1 if waffle[n][runner] == "@"
        end
        runner += 1
      end

      return "IMPOSSIBLE" unless chips_left == 0


      cuts += 1
      chips_left = chips_per_v_cut
      v_cuts << runner unless cuts == v + 1
    end

    chips_per_cut = total_chips / customers

        # puts "h_cuts #{h_cuts} v_cuts #{v_cuts}"

    h_runner = 0
    while h_cuts.count > 0
      v_cuts_copy = v_cuts.dup

      # puts "v_cuts_copy #{v_cuts_copy}"

      next_h = h_cuts.shift

      v_runner = 0
      while v_cuts_copy.count > 0
        next_v = v_cuts_copy.shift

        unless count_section(h_runner, next_h, v_runner, next_v, waffle) == chips_per_cut
          # puts "h_runner #{h_runner} next_h #{next_h} v_runner #{v_runner} next_v #{next_v}"
          # puts "count #{count_section(h_runner, next_h, v_runner, next_v, waffle)}"
          # puts "chips_per_cut #{chips_per_cut}"
          return "IMPOSSIBLE"
        end

        v_runner = next_v
      end

      h_runner = next_h
    end


    # [r, c, h, v, waffle, total_chips, customers]
    "POSSIBLE"
  end



  def count_section(from_h, to_h, from_v, to_v, waffle)
    # puts "**************"
    count = 0
    (from_h...to_h).each do |h|
      (from_v...to_v).each do |v|
        # puts "h #{h} v #{v}"
        count += 1 if waffle[h][v] == "@"
      end
    end

    count
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  waffle = []
  inputs[0].times do
    waffle << lines.shift.split("")
  end
  value = Solver.new.solve(inputs[0], inputs[1], inputs[2], inputs[3], waffle)
  puts "Case \##{index + 1}: #{value}"
end
