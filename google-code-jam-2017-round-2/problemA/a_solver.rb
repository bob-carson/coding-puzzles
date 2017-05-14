class ASolver
  def solve(p, groups)
    groups.map! { |g| g % p }

    counts = {}
    (0...p).each { |n| counts[n] = 0 }

    groups.each do |g|
      counts[g] += 1
    end

    # puts counts

    counts[0] + _non_zero(p, counts)
  end

  def _non_zero(p, counts)
    if p == 2
      _two(counts)
    elsif p == 3
      _three(counts)
    elsif p == 4
      _four(counts)
    else
      raise "Unsupported p"
    end
  end

  def _two(counts)
    (counts[1] + 1) / 2
  end

  def _three(counts)
    n = 0
    while counts[2] > 0 && counts[1] > 0
      counts[2] -= 1
      counts[1] -= 1
      n += 1
    end
    while counts[1] > 2
      counts[1] -= 3
      n += 1
    end
    while counts[2] > 2
      counts[2] -= 3
      n += 1
    end
    unless counts[2] == 0 && counts[1] == 0
      n += 1
    end
    n
  end

  def _four(counts)
    n = 0
    while counts[3] > 0 && counts[1] > 0
      counts[3] -= 1
      counts[1] -= 1
      n += 1
    end
    while counts[3] > 3
      counts[3] -= 4
      n += 1
    end
    while counts[2] > 1
      counts[2] -= 2
      n += 1
    end
    while counts[3] > 1 && counts[2] > 0
      counts[3] -= 2
      counts[2] -= 1
      n += 1
    end
    while counts[2] > 0 && counts[1] > 1
      counts[2] -= 1
      counts[1] -= 2
      n += 1
    end
    while counts[1] > 3
      counts[1] -= 4
      n += 1
    end
    unless counts[3] == 0 && counts[2] == 0 && counts[1] == 0
      n += 1
    end
    n
  end
end
