#!/usr/bin/env ruby

def log(string)
  # puts string
end

def log_short(string)
  puts string
end

class Solver
  def solve(r, c, grid)
    patterns = []
    (0...r).each do |i|
      (0...c).each do |j|
        patterns << [[i, j]]
      end
    end

    n = 1

    do_continue = true

    while do_continue
      next_to_check = patterns.flat_map do |pattern|
        next_to_check(pattern, r, c)
      end.uniq

      log "n #{n} next to check count #{next_to_check.count}"

      new_patterns = next_to_check.select { |n| is_pattern?(n, grid) }

      if new_patterns.count == 0
        do_continue = false
      else
        n += 1
        patterns = new_patterns
      end
    end

    log_short "answers #{patterns}"
    log_short "first metadata #{pattern_metadata(patterns[0], grid)}"
    log_short "grid #{grid}"

    # is_pattern?(all_pattern, grid)

    n
  end

  def next_to_check(pattern, r, c)
    borders = []

    pattern.each do |cell|
      north = [cell[0], cell[1] + 1]
      east = [cell[0] + 1, cell[1]]
      south = [cell[0], cell[1] - 1]
      west = [cell[0] - 1, cell[1]]

      [north, east, south, west].each do |border|
        next unless valid_border?(border, pattern, r, c)

        borders << border
      end
    end

    borders.uniq.map do |b|
      (pattern + [b]).sort
    end
  end

  def valid_border?(border, pattern, r, c)
    return false if border[0] < 0 || border[0] >= r
    return false if border[1] < 0 || border[1] >= c
    return false if pattern.include?(border)

    true
  end

  def is_pattern?(pattern, grid)
    if is_all_one_color?(pattern, grid)
      log "all one color #{pattern}"
      return true
    end

    metadata = pattern_metadata(pattern, grid)

    if is_vert_split?(metadata)
      log "vert split #{pattern}"
      return true
    end
    if is_horiz_split?(metadata)
      log "horiz split #{pattern}"
      return true
    end

    if has_multi_switchs?(metadata)
      log "has multi switches #{pattern}"
      return false
    end

    if is_checker?(metadata, pattern, grid)
      log "has multi switches #{pattern}"
      return true
    end

    log_short "metadata #{metadata} pattern #{pattern}"
    # raise "I'm here"
    false
  end

  # def is_vert_split?(pattern, grid)
  #   sorted_pattern = pattern.sort_by { |cell| cell[1] }
  #
  #   current_color = grid[sorted_pattern[0][0]][sorted_pattern[0][1]]
  #   has_switched_colors = false
  #
  #   sorted_pattern.each do |cell|
  #     next if grid[cell[0]][cell[1]] == current_color
  #
  #     if has_switched_colors
  #       return false
  #     else
  #       current_color = grid[cell[0]][cell[1]]
  #       has_switched_colors = true
  #     end
  #   end
  #
  #   true
  # end

  def is_checker?(metadata, pattern, grid)
    current_colors = metadata[:rows].first[:colors]
    has_switched_colors = false

    metadata[:rows].each do |row|
      next_color = row[:colors]
      next if next_color == current_colors

      if is_subset_color?(next_color, current_colors, pattern, grid)
        current_colors = next_color
      else
        if has_switched_colors
          return false
        else
          has_switched_colors = true
          current_colors = next_color
        end
      end
    end

    current_colors = metadata[:columns].first[:colors]
    has_switched_colors = false

    metadata[:columns].each do |row|
      next_color = row[:colors]
      next if next_color == current_colors

      if is_subset_color?(next_color, current_colors, , pattern, grid)
        current_colors = next_color
      else
        if has_switched_colors
          return false
        else
          has_switched_colors = true
          current_colors = next_color
        end
      end
    end

    true
  end

  def is_subset_color?(next_color, current, next_square, pattern, grid)
    return true if next_color == current
    if next_color.count == 2 && current.count == 1

    end

    false
  end

  def has_multi_switchs?(metadata)
    return true if metadata[:rows].any? { |r| r[:colors].count > 2 }
    return true if metadata[:columns].any? { |r| r[:colors].count > 2 }

    false
  end

  def pattern_metadata(pattern, grid)
    rows = pattern.map { |cell| cell[0] }.uniq.sort
    columns = pattern.map { |cell| cell[1] }.uniq.sort

    row_data = rows.map do |row|
      column_arr_runner = 0
      next_column = columns[column_arr_runner]

      while !pattern.include?([row, next_column])
        column_arr_runner += 1
        next_column = columns[column_arr_runner]
      end

      first_color = grid[row][next_column]
      colors = [first_color]

      while column_arr_runner < columns.count
        unless pattern.include?([row, next_column])
          column_arr_runner += 1
          next_column = columns[column_arr_runner]
          next
        end

        if grid[row][next_column] != colors.last
          colors << grid[row][next_column]
        end

        column_arr_runner += 1
        next_column = columns[column_arr_runner]
      end

      {
        :index => row,
        :colors => colors
      }
    end

    column_data = columns.map do |column|
      row_arr_runner = 0
      next_row = rows[row_arr_runner]

      while !pattern.include?([next_row, column])
        row_arr_runner += 1
        next_row = rows[row_arr_runner]
      end

      first_color = grid[next_row][column]
      colors = [first_color]

      while row_arr_runner < rows.count
        unless pattern.include?([next_row, column])
          row_arr_runner += 1
          next_row = rows[row_arr_runner]
          next
        end

        if grid[next_row][column] != colors.last
          colors << grid[next_row][column]
        end

        row_arr_runner += 1
        next_row = rows[row_arr_runner]
      end

      {
        :index => column,
        :colors => colors
      }
    end

    # log "row_data #{row_data}"
    {
      :rows => row_data,
      :columns => column_data,
    }
  end

  def is_vert_split?(metadata)
    return false unless metadata[:rows].all? { |r| r[:colors].count <= 2 }
    return false unless metadata[:columns].all? { |r| r[:colors].count == 1 }

    true
  end

  def is_horiz_split?(metadata)
    return false unless metadata[:columns].all? { |r| r[:colors].count <= 2 }
    return false unless metadata[:rows].all? { |r| r[:colors].count == 1 }

    true
  end


  #
  # def is_horiz_split?(pattern, grid)
  #   sorted_pattern = pattern.sort_by { |cell| cell[0] }
  #
  #   current_color = grid[sorted_pattern[0][0]][sorted_pattern[0][1]]
  #   has_switched_colors = false
  #
  #   sorted_pattern.each do |cell|
  #     next if grid[cell[0]][cell[1]] == current_color
  #
  #     if has_switched_colors
  #       return false
  #     else
  #       current_color = grid[cell[0]][cell[1]]
  #       has_switched_colors = true
  #     end
  #   end
  #
  #   true
  # end

  def is_all_one_color?(pattern, grid)
    color = grid[pattern[0][0]][pattern[0][1]]

    pattern.each do |cell|
      return false unless grid[cell[0]][cell[1]] == color
    end

    true
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  grid = []
  inputs[0].times do
    grid << lines.shift.split("")
  end
  value = Solver.new.solve(inputs[0], inputs[1], grid)
  puts "Case \##{index + 1}: #{value}"
end
