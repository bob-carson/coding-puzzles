#!/usr/bin/env ruby

class Solver
  def solve(cj_cost,jc_cost,mural)
    letters = _compact_mural(mural).split('')
    return 0 if letters.length == 1

    cost = 0
    last_letter = letters[0]

    if letters[0] == "?"
      last_letter = _fill_first_letter(cj_cost,jc_cost,letters[1])
    end
      # puts "letter #{letters[0]}"
    (1..letters.length - 1).each do |i|
      # puts "cost #{cost} letter #{letters[i]}"
      if letters[i] == "C"
        if last_letter == "J"
          cost += jc_cost
        end
        last_letter = letters[i]
      elsif letters[i] == "J"
        if last_letter == "C"
          cost += cj_cost
        end
        last_letter = letters[i]
      elsif letters[i] == "?"
        next_letter = i < letters.length ? letters[i+1] : nil
        fill_letter = nil

        if next_letter == nil
          fill_letter = _fill_last_letter(cj_cost,jc_cost,last_letter)
        else
          fill_letter = _fill_mid_letter(cj_cost,jc_cost,last_letter,next_letter)
        end

        if last_letter == "J" && fill_letter == "C"
          cost += jc_cost
        elsif last_letter == "C" && fill_letter == "J"
          cost += cj_cost
        end

        last_letter = fill_letter
      else
        raise "Unexpected character #{letters[i]}"
      end
    end
      # puts "cost #{cost}"

    cost
  end

  def _compact_mural(mural)
    # This will break things if costs can be negative

    mural.gsub(/\?+/, "?")
  end

  def _fill_first_letter(cj_cost,jc_cost,next_letter)
    if next_letter == "C"
      # return "J" if jc_cost < 0

      return "C"
    elsif next_letter == "J"
      # return "C" if cj_cost < 0

      return "J"
    else
      raise "Unexpected character #{next_letter}"
    end
  end

  def _fill_last_letter(cj_cost,jc_cost,last_letter)
    if last_letter == "C"
      # return "J" if cj_cost < 0

      return "C"
    elsif last_letter == "J"
      # return "C" if jc_cost < 0

      return "J"
    else
      raise "Unexpected character #{next_letter}"
    end
  end

  def _fill_mid_letter(cj_cost,jc_cost,last_letter,next_letter)
    raise "Unexpected character #{last_letter} or #{next_letter}" if last_letter == "?" || next_letter == "?"

    return next_letter
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  i = lines.shift.split(" ")
  out = Solver.new.solve(i[0].to_i, i[1].to_i, i[2])
  puts "Case \##{index + 1}: #{out}"
end
