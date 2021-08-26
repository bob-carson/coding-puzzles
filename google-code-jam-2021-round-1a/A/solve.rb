#!/usr/bin/env ruby

class Solver
  def solve(list)
    digits = list.map { |i| to_digits(i) }
    # puts "digits #{digits}"

    last_num = list[0]
    runner = 1
    append_count = 0
    while runner < list.length
      if list[runner] > last_num
        # puts "list[runner] #{list[runner]} > last_num #{last_num} skipping"
        last_num = list[runner]
        runner += 1
        next
      end

      beginning_current = list[runner]
      beginning_last = to_num(to_digits(last_num)[0...(digits[runner].length)])

      # puts "beginning_current #{beginning_current} beginning_last #{beginning_last}"

      if beginning_current > beginning_last
        while digits[runner].length < digits[runner - 1].length
          digits[runner] << 0
          append_count += 1
        end
        last_num = to_num(digits[runner])
        # puts "case 1 last_num #{last_num}"
      elsif beginning_current < beginning_last
        while digits[runner].length <= digits[runner - 1].length
          digits[runner] << 0
          append_count += 1
        end
        last_num = to_num(digits[runner])
        # puts "case 2 last_num #{last_num}"

      else
        candidate = last_num + 1
        if to_digits(candidate).take(digits[runner].length) == digits[runner]
          last_num += 1
          digits[runner] = to_digits(last_num)
          append_count += digits[runner].length - to_digits(list[runner]).length
          # puts "case 3 last_num #{last_num}"
        else
          while digits[runner].length <= digits[runner - 1].length
            digits[runner] << 0
            append_count += 1
          end
          last_num = to_num(digits[runner])
          # puts "case 4 last_num #{last_num}"
        end
      end

      runner += 1
    end

    append_count
  end

  def to_digits(num)
    num.to_s.split("").map(&:to_i)
  end

  def to_num(digits)
    # puts "to_num digits #{digits}"
    digits.map(&:to_s).join("").to_i
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  n = lines.shift.to_i
  list = lines.shift.split(" ").map(&:to_i)
  out = Solver.new.solve(list)
  puts "Case \##{index + 1}: #{out}"
end
