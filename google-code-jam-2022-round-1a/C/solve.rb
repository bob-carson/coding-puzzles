#!/usr/bin/env ruby

class Solver
  def solve(weight_requirements)
    puts "#{weight_requirements}"

    base_section = Array.new(weight_requirements[0].count) { 9999 }

    weight_requirements.each do |weight_req|
      weight_req.each_with_index do |e, i|
        if e < base_section[i]
          base_section[i] = e
        end
      end
    end

    moves = weight_requirements[0].sum
    weight_index = 0

    sections = [base_section]
    second_section = _diff_sections(weight_requirements[0], base_section)
    sections << second_section unless second_section.all? { |x| x == 0 }

    puts "weight_index: #{weight_index} sections: #{sections} moves #{moves}"
    while weight_index < weight_requirements.count - 1
      to_add = _diff_sections(weight_requirements[weight_index + 1], weight_requirements[weight_index])
      puts "  to_add #{to_add}"

      if _can_remove_from_top?(sections.last, to_add)
        second_section = _subtract_negatives(sections.pop, to_add)
        sections << second_section unless second_section.all? { |x| x == 0 }
        positives = _select_positives(to_add)
        sections << positives unless positives.all? { |x| x == 0 }
        moves += to_add.sum { |e| e.abs }
      else
        sections_above = [sections.pop, _select_positives(to_add)]
        puts "  sections_above #{sections_above}"
        done = false

        while !done
          can_remove_from_next = _can_remove_from(sections.last, to_add)

        end


        puts "-*-*-*- CANNOT remove from top section"
        return
      end


      weight_index += 1
      puts "weight_index: #{weight_index} sections: #{sections} moves #{moves}"
    end

    moves += weight_requirements.last.sum
    moves
  end

  def _can_remove_from(super_section, to_add)
    (0...super_section.count).map do |i|
      return 0 if to_add[i] >= 0

      [super_section[i], -1 * to_add[i]].min
    end
  end

  def _subtract_negatives(original_section, negative_section)
    (0...original_section.count).map do |i|
      if negative_section[i] < 0
        original_section[i] + negative_section[i]
      else
        original_section[i]
      end
    end
  end

  def _select_positives(section)
    section.map { |e| e > 0 ? e : 0 }
  end

  def _all_nonnegative?(section)
    section.all? { |e| e >= 0 }
  end

  def _can_remove_from_top?(super_section, sub_section)
    (0...super_section.count).all? { |i| sub_section[i] >= 0 || sub_section[i] * -1 <= super_section[i] }
  end

  def _diff_sections(a, b)
    a.zip(b).map { |a_e, b_e| a_e - b_e }
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  e = lines.shift.split(" ").map(&:to_i)[0]
  weight_requirements = []
  e.times do |j|
    weight_requirements << lines.shift.split(" ").map(&:to_i)
  end
  out = Solver.new.solve(weight_requirements)
  puts "Case \##{index + 1}: #{out}"
end
