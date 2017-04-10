class BathroomSolver
  UP = "0"
  DOWN = "1"

  def solve(n, k)
    roundings = k.to_s(2).split("")
    roundings.shift
    roundings.reverse!

    result = n

    roundings.each do |r|
      if r == UP
        result = up(result)
      else
        result = down(result)
      end
    end

    up(result).to_s + " " + down(result).to_s
  end

  def up(n)
    ((n - 1) / 2.0).ceil
  end

  def down(n)
    ((n - 1) / 2.0).floor
  end
end
