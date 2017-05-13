class CSolver
  def solve(n, u, probabilities)
    probabilities.sort!

    runner = 0
    while u > 0 && runner < probabilities.count
      # puts "probs #{probabilities.map { |pr| "%.9f" % pr}}"
      # puts "u #{_display(u)}"
      # puts "runner #{runner}"

      next_value = probabilities[runner + 1] || 1
      if probabilities[runner] == next_value
        runner += 1
        # puts "bailing"
        next
      end

      difference = (next_value - probabilities[runner])
      if (difference * (runner + 1)) > u
        (0..runner).each do |i|
          probabilities[i] += (u / (runner + 1))
        end
        u = 0
      else
        (0..runner).each do |i|
          probabilities[i] += difference
        end
        u -= difference * (runner + 1)
      end
      runner += 1
    end

    "%.9f" % probabilities.inject { |prob, product| prob * product }
  end

  def _display(big_dec)
    "%.9f" % big_dec
  end
end
