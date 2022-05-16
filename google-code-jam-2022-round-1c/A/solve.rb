#!/usr/bin/env ruby

class Solver
  def solve(towers)
    split_towers = towers.map do |tower|
      tower_chars = tower.split("")

      middle = tower_chars.uniq
      middle.delete(tower_chars.first)
      middle.delete(tower_chars.last)

      [tower_chars.first, middle, tower_chars.last, tower]
    end

    all_start = []
    all_middle = []
    all_end = []
    split_towers.each do |split_tower|
      all_start << split_tower[0]
      all_middle.push(*(split_tower[1]))
      all_end << split_tower[2]
    end

    return "IMPOSSIBLE" if all_middle.uniq.length < all_middle.length
    (all_start + all_end).each do |ch|
      return "IMPOSSIBLE" if all_middle.include?(ch)
    end
    split_towers.each do |split_tower|
      return "IMPOSSIBLE" if split_tower[1].length > 0 && split_tower[0] == split_tower[2]
    end

    # puts "split_towers: #{split_towers}"
    filter_single_letters = split_towers.filter do |split_tower|
      split_tower[0] != split_tower[2]
    end
    # puts "filter_single_letters: #{filter_single_letters}"
    filter_single_letters.each do |split_tower|
      return "IMPOSSIBLE" if filter_single_letters.any? { |t| split_tower != t && (split_tower[0] == t[0] || split_tower[2] == t[2]) }
    end

    multi_tower = ""

      # puts "- split_towers: #{split_towers}"
    single_letter_towers = split_towers.filter do |split_tower|
      split_tower[0] == split_tower[2]
    end
    single_letter_towers.each do |tower|
      split_towers.delete(tower)
    end
      # puts "$ split_towers: #{split_towers}"
    single_letter_towers.each do |tower|
      inject_into = split_towers.detect do |split|
        split[3].include?(tower[0])
      end
      if inject_into != nil
        inject_index = inject_into[3].index(tower[0])
        inject_into[3].insert(inject_index + 1, tower[3])
      else
        multi_tower << tower[3]
      end
    end

    return multi_tower if split_towers.length == 0
      # puts "^ split_towers: #{split_towers} multi_tower: #{multi_tower}"


    start = split_towers.detect do |split_tower|
      first_char = split_tower[0]
      split_towers.none? { |t| t[2] == first_char }
    end

    return "IMPOSSIBLE" if start == nil

    multi_tower << start[3]
    split_towers.delete(start)

    while split_towers.size > 0
      # puts "split_towers: #{split_towers}"

      next_char = multi_tower[-1]
      # puts "multi_tower: #{multi_tower} next_char: #{next_char}"

      next_split = split_towers.detect do |split_tower|
        split_tower[0] == next_char
      end

      # puts "(1) next_split: #{next_split}"
      if next_split == nil
        next_split = split_towers.detect do |split_tower|
          first_char = split_tower[0]
          split_towers.none? { |t| t[2] == first_char }
        end
      end

      if next_split == nil
        return "IMPOSSIBLE"
      end

      multi_tower << next_split[3]
      split_towers.delete(next_split)
    end

    multi_tower
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  towers = lines.shift.split(" ")
  out = Solver.new.solve(towers)
  puts "Case \##{index + 1}: #{out}"
end
