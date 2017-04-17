class RatSolver
  def solve(required, packages)
    options = Array.new(required.count) { {} }

    num = 0

    a = Array.new(required.count)

    while num < required.count
      req = required[num]

      a[num] = packages[num].map { |p| can_make(req, p) }.compact.sort do |a, b|
        if a.min == b.min
          a.max <=> b.max
        else
          a.min <=> b.min
        end
      end

      num += 1
    end

    count = 0


        # p "#{[required, packages]}"
        # p "#{a}"

    if a[0].count > 0
      try = a[0][0].min
    end

    while a[0].count > 0
      next_indices = Array.new(required.count, nil)
      next_indices[0] = {} # not nil

      (1...next_indices.count).each do |i|
        next_indices[i] = 0

        while next_indices[i] < a[i].count && !a[i][next_indices[i]].include?(try)
          next_indices[i] += 1
        end

        if next_indices[i] == a[i].count
          next_indices[i] = nil
          # p "can't find for #{i}"
          break
        end
      end

      if next_indices.include?(nil)
        try += 1
        if try > a[0][0].max
          a[0].shift
          if a[0].count > 0
            try = a[0][0].min
          end
        end
      else
        a[0].shift
        (1...a.count).each do |i|
          a[i].shift(next_indices[i] + 1)
        end

        if a[0].count > 0
          try = a[0][0].min
        end
        count += 1
      end
    end

    # p "#{[required, packages]}"
    # p "#{a}"

    count
  end

  def can_make(req, pack)
    min = (pack / (1.1 * req)).ceil
    max = (pack / (0.9 * req)).floor

    return nil if min > max

    (min..max)
  end
end
