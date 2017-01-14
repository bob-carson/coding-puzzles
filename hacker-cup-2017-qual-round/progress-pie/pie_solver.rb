class PieSolver
  def self.solve(percent, x, y)
    return "white" unless is_in_circle?(x, y)

    percent(x, y) < percent ? "black" : "white"
  end

  private

  def self.is_in_circle?(x, y)
    (x - 50) ** 2 + (y - 50) ** 2 <= 50 ** 2
  end

  def self.percent(x, y)
    theta = (Math.atan2(y - 50, x - 50) - (Math::PI / 2)) * -1
    if theta < 0
      theta += Math::PI * 2
    end
    theta * 50 / Math::PI
  end
end
