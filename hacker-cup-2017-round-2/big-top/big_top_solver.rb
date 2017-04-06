class BigTopSolver
  def self.solve(n, x_values, h_values)
    posts = expand_series(*x_values, n).zip(expand_series(*h_values, n))

    used_posts = []
    total_area = 0
    current_area
    control = []

    while posts.count > 0
      next_post = posts.shift
      x = next_post[0]
      h = next_post[1]

      start = x - h
      stop = (x + h)

      if control.count == 0
        control << [start, stop, next_post]

        current_area = h * h
        total_area = current_area

        next
      end

      i = control.bsearch_index { |c| c[0] > start } - 1

      if i == -1
        # first one
      else
        if
        int_x = intersection(next_post, control[i][2])
        while int_x > control[i][1]
          i += 1
          int_x = intersection(next_post, control[i][2])
        end
      end

      if control[i][0] < start
    end

    used_posts
  end

  private

  def self.encloses?(big, small)
    small[1] < (big[0] - small[0]).abs
  end

  def self.intersection(post0, post1)
    if post0[0] > post1[1]
      post0_left = post0[0] - post0[1]
      post1_right = post1[0] + post1[1]
      if post0_left <= post1_right
        (post0_left + post1_right) / 2
      else
        nil
      end
    else
      post1_left = post1[0] - post1[1]
      post0_right = post0[0] + post0[1]
      if post1_left <= post0_right
        (post1_left + post0_right) / 2
      else
        nil
      end
    end
  end

  def self.expand_series(first, a, b, c, n)
    series = [first]
    (n-1).times do
      series << ((((a * series.last) + b) % c) + 1)
    end
    series
  end
end
