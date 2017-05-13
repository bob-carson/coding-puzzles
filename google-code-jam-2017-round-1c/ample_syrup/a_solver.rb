require "bigdecimal"

class ASolver
  @@pi = BigDecimal.new(Math::PI.to_s)

  def solve(k, pancakes)
    pancakes.sort_by! { |pan| -1 * pan[0] }

    # p "sorted #{pancakes}"

    pancakes.each do |pan|
      pan << pan[0] * pan[1]
    end

    check_biggest = pancakes.count - k

    answer = (0..check_biggest).map do |n|
      _area_for_biggest(k, pancakes[n..-1])
    end.max * @@pi

    "%.9f" % answer
  end

  def _area_for_biggest(k, pancakes)
    # p "Checking #{pancakes}"
    area =  pancakes[0][0] ** 2 + 2 * pancakes[0][2]

    area += 2 * pancakes[1..-1].max_by(k - 1) { |p| p[2] }.inject(0) { |sum, pan|
      sum + pan[2]
    }

    # puts area
    area
  end
end
