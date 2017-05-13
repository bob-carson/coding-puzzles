require "bigdecimal"

class CSolver
  def solve(n, k, u, probabilities)
    probabilities.sort!

    an = (0..n).map { |i| subsolve(n, k, u, probabilities, i) }.max

    _display(subsolve(n, k, u, probabilities, an))
  end

  def subsolve(n, k, u, in_probs, discard)
    probabilities = in_probs.clone

    unused = probabilities.shift(n - k)

    runner = 0
    while u > 0 && runner < probabilities.count
      # puts "probs #{probabilities.map { |pr| "%.9f" % pr}}"
      # puts "u #{_display(u)}"
      # puts "runner #{runner}"
      # puts "old answer #{_display(probabilities.inject { |prob, product| prob * product })}"

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

    # throw "u greater than 0 #{_display(u)}" if u > 0


    probabilities.push(*unused)

    _success(k, probabilities)
  end

  def _success(k, probabilities)
    matrix = [[BigDecimal.new("1.0")]]
    max_losses = probabilities.count - k + 1

    probabilities.each_with_index do |prob, i|
      row = Array.new(i + 2) { BigDecimal.new("0.0") }
      matrix[i].each_with_index do |cell, j|
        row[j] += (1 - prob) * cell
        row[j + 1] += prob * cell
      end

      matrix << row
    end

    matrix[-1][k..-1].inject { |prob, sum| prob + sum}
  end

  def _display(big_dec)
    "%.9f" % big_dec
  end
end
