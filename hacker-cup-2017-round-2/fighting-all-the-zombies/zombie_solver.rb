class ZombieSolver
  def self.solve(n, m, w_values, d_values, s_values)
    w_series = expand_w_series(*w_values, n, m)
    d_series = expand_d_series(*d_values, m)
    z_series = expand_z_series(d_series, w_series, n)
    s_series = expand_s_series(*s_values, m)

    wands = {}

    (1..n).each { |i| wands[i] = { i => 1, (i+1) => 0, (i-1) => 0 } }

    answer = (0...m).map do |i|
      w_i = w_series[i]
      z_i = z_series[i]
      s_i = s_series[i]

      wands[w_i][z_i] += s_i

      permutations(wands, n)
    end.inject(&:+)



    answer % 1_000_000_007
  end

  private

  def self.permutations(wands, n)
    next_wand = 1

    no_swaps = []
    swaps = []
    (1..n).each do |i|
      no_swaps << wands[i][i]

      if i != n
        swaps << wands[i][i+1] * wands[i+1][i]
      end
    end

    i = 1

    [true, false].repeated_combination(n-1).map do |ar|
      total = 1

      i = 0
      while i < n
        if i != 0 && ar[i] && ar[i-1]
          total = 0
          break
        end

        if ar[i]
          total *= swaps[i]
          i += 2
        else
          total *= no_swaps[i]
          i += 1
        end
      end

      total
    end.inject(&:+)


    # [no_swaps, swaps]
  end



  def self.expand_w_series(first, a, b, n, m)
    series = [first]
    (m-1).times do
      series << ((((a * series.last) + b) % n) + 1)
    end
    series
  end

  def self.expand_d_series(first, a, b, m)
    series = [first]
    (m-1).times do
      series << ((a * series.last) + b) % 3
    end
    series
  end

  def self.expand_z_series(d_series, w_series, n)
    (0...d_series.count).map { |i| [1, [n, w_series[i] + d_series[i] - 1].min].max }
  end

  def self.expand_s_series(first, a, b, m)
    series = [first]
    (m-1).times do
      series << ((((a * series.last) + b) % 1_000_000_000) + 1)
    end
    series
  end
end
