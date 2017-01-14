class LlSolver
  def self.solve(weights)
    weights.sort!

    bottom_items_moved = 0
    trips = 0

    while bottom_items_moved < weights.count
      top_weight = weights.pop
      num_bottom = [0, (50.0 / top_weight).ceil - 1].max

      bottom_items_moved += num_bottom
      if bottom_items_moved <= weights.count
        trips += 1
      end
    end

    trips
  end
end
