class TidySolver
  def solve(number)
    digits = number.split("").map(&:to_i)

    return number if digits.length == 1

    runner = digits.length - 2

    while runner >= 0

      if digits[runner] > digits[runner + 1]
        if runner == 0 && digits[0] == 1
          return ("9" * (digits.length - 1))
        end

        digits[runner] -= 1
        ((runner+1)...(digits.length)).each do |i|
          digits[i] = 9
        end
      end

      runner -= 1
    end

    digits.join("")
  end
end
