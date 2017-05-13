class AlphaSolver
  def solve(grid)
    @grid = grid
    map = {}

    (0...grid.count).each do |row|
      (0...grid[row].count).each do |col|
        if grid[row][col]
          letter = grid[row][col]
          map[letter] ||= []
          map[letter] << [row, col]
        end
      end
    end

    map.each do |letter, starting|
      x0 = starting.min { |s| s[0] }[0]
      x1 = starting.max { |s| s[0] }[0]
      y0 = starting.min { |s| s[1] }[1]
      y1 = starting.max { |s| s[1] }[1]

      while can_go_left(x0, y0, y1)
        go_left(letter, x0, y0, y1)
        x0 -= 1
      end

      while can_go_right(x1, y0, y1)
        go_right(letter, x1, y0, y1)
        x1 += 1
      end

      # p "#{x0} #{x1} #{y0} #{y1}"
    end

    map = {}

    (0...grid.count).each do |row|
      (0...grid[row].count).each do |col|
        if grid[row][col]
          letter = grid[row][col]
          map[letter] ||= []
          map[letter] << [row, col]
        end
      end
    end

    map.each do |letter, starting|
      x0 = starting.min { |s| s[0] }[0]
      x1 = starting.max { |s| s[0] }[0]
      y0 = starting.min { |s| s[1] }[1]
      y1 = starting.max { |s| s[1] }[1]

      while can_go_up(x0, x1, y0)
        go_up(letter, x0, x1, y0)
        y0 -= 1
      end

      while can_go_down(x0, x1, y1)
        go_down(letter, x0, x1, y1)
        y1 += 1
      end

      # p "#{x0} #{x1} #{y0} #{y1}"
    end

    # p "#{map}"
    # p "#{grid}"

    grid.each do |row|
      if row.include?(nil)
        p "here it is"
        p "#{grid}"
        throw "adjnf"
      end
    end

    "\n" + grid.map { |r| r.join("") }.join("\n")
  end

  def can_go_down(x0, x1, y1)
    return false if y1 == @grid[0].count - 1

    (x0..x1).each do |x|
      if @grid[x][y1 + 1]
        return false
      end
    end

    true
  end

  def go_down(letter, x0, x1, y1)
    (x0..x1).each do |x|
      @grid[x][y1 + 1] = letter
    end
  end


  def can_go_up(x0, x1, y0)
    return false if y0 == 0

    (x0..x1).each do |x|
      if @grid[x][y0 - 1]
        return false
      end
    end

    true
  end

  def go_up(letter, x0, x1, y0)
    (x0..x1).each do |x|
      @grid[x][y0 - 1] = letter
    end
  end

  def can_go_left(x0, y0, y1)
    return false if x0 == 0

    (y0..y1).each do |y|
      if @grid[x0 - 1][y]
        return false
      end
    end

    true
  end

  def go_left(letter, x0, y0, y1)
    (y0..y1).each do |y|
      @grid[x0 - 1][y] = letter
    end
  end

  def can_go_right(x1, y0, y1)
    return false if x1 == @grid.count - 1

    (y0..y1).each do |y|
      if @grid[x1 + 1][y]
        return false
      end
    end

    true
  end

  def go_right(letter, x1, y0, y1)
    (y0..y1).each do |y|
      @grid[x1 + 1][y] = letter
    end
  end
end
