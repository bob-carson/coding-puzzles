require "bigdecimal"

class CorrectBathroomSolver
  def solve(n, k)
    openings = { BigDecimal.new(n) => 1 }
    placed = 0

    while true
      i = openings.keys.max
      num = openings.delete(i)

      placed += num

      if k <= placed
        return up(i).to_s + " " + down(i).to_s
      end

      u = BigDecimal.new(up(i))
      openings[u] ||= 0
      openings[u] += num

      d = BigDecimal.new(down(i))
      openings[d] ||= 0
      openings[d] += num
    end
  end

  def up(n)
    ((n - 1) / 2.0).ceil
  end

  def down(n)
    ((n - 1) / 2.0).floor
  end
end
