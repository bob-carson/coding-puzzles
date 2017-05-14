class CSolver
  V_BEAM = '|'
  H_BEAM = '-'
  WALL = '#'
  EMPTY = '.'
  L_MIRROR = '\\'
  R_MIRROR = '/'

  RIGHT = 'R'
  LEFT = 'L'
  UP = 'U'
  DOWN = 'D'

  def solve(grid)
    @grid = grid
    @height = grid.count
    @width = grid[0].count
    beams = []
    empties = []
    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell == V_BEAM || cell == H_BEAM
          beams << [i, j]
        elsif cell == EMPTY
          empties << [i,j]
        end
      end
    end

    # puts "#{beams}"
    # puts "#{empties}"

    beam_covers = beams.map do |beam|
      # puts "beam #{beam}"
      v = _vertical_covers(beam[0], beam[1])
      # puts "vert covers #{v ? v : 'bad'}"
      h = _horiz_covers(beam[0], beam[1])
      # puts "hor covers #{h ? h : 'bad'}"
      return "IMPOSSIBLE" unless v || h
      [beam, v, h]
    end

    beam_covers.select! do |beam_cover|
      if beam_cover[1] == nil
        @grid[beam_cover[0][0]][beam_cover[0][1]] = H_BEAM
        beam_cover[2].each { |p| empties.delete(p) }
        false
      elsif beam_cover[2] == nil
        @grid[beam_cover[0][0]][beam_cover[0][1]] = V_BEAM
        beam_cover[1].each { |p| empties.delete(p) }
        false
      else
        true
      end
    end

    # puts "beams left #{beam_covers}"
    # puts "still empty #{empties}"

    [1, 2].repeated_combination(beam_covers.length).each do |combo|
      empties_copy = empties.clone

      combo.each_with_index do |a, i|
        beam_covers[i][a].each { |p| empties_copy.delete(p) }
      end

      if empties_copy.count == 0
        combo.each_with_index do |a, i|
          if a == 2
            @grid[beam_covers[i][0][0]][beam_covers[i][0][1]] = H_BEAM
          else
            @grid[beam_covers[i][0][0]][beam_covers[i][0][1]] = V_BEAM
          end
        end

        return "POSSIBLE\n" + grid.map { |r| r.join("") }.join("\n")
      end
    end

    # puts"#{grid}"
    "IMPOSSIBLE"
  end

  def _vertical_covers(i,j)
  # puts "*****"
    up = _beam_covers(UP, [i, j])
    return nil unless up
    # puts "*****"
    down = _beam_covers(DOWN, [i, j])
    if up && down
      up + down
    end
  end

  def _horiz_covers(i,j)
  # puts "*****"
    up = _beam_covers(RIGHT, [i, j])
        return nil unless up
    # puts "*****"
    down = _beam_covers(LEFT, [i, j])
    if up && down
      up + down
    end
  end

  def _beam_covers(direction, start)
  # puts "tracing #{start}"
    next_square = nil
    if direction == RIGHT
      next_square = [start[0], start[1] + 1]
    elsif direction == LEFT
      next_square = [start[0], start[1] - 1]
    elsif direction == DOWN
      next_square = [start[0] + 1, start[1]]
    elsif direction == UP
      next_square = [start[0] - 1, start[1]]
    else
      raise "bad direction"
    end

    # puts "#{next_square}"
    return nil if _is_beam(next_square[0], next_square[1])
    # if _is_beam(next_square[0], next_square[1])
    #   puts "beam"
    #   return nil
    # end
    return [] if _is_stop(next_square[0], next_square[1])

    next_direction = direction
    result = []
    next_value = @grid[next_square[0]][next_square[1]]

    if next_value == EMPTY
      result = [next_square]
    elsif next_value == L_MIRROR
      if direction == RIGHT
        next_direction = DOWN
      elsif direction == LEFT
        next_direction = UP
      elsif direction == DOWN
        next_direction = RIGHT
      elsif direction == UP
        next_direction = LEFT
      else
        raise "bad direction"
      end
    elsif next_value == R_MIRROR
      if direction == RIGHT
        next_direction = UP
      elsif direction == LEFT
        next_direction = DOWN
      elsif direction == DOWN
        next_direction = LEFT
      elsif direction == UP
        next_direction = RIGHT
      else
        raise "bad direction"
      end
    else
      raise "bad square"
    end

    recurs = _beam_covers(next_direction, next_square)

    return nil unless recurs

    result + recurs
  end

  # def _is_empty(i,j)
  #   @grid[i][j] == EMPTY
  # end


  # L_MIRROR = '\\'
  # R_MIRROR = '/'

  def _is_stop(i,j)
    return true if i < 0 || i >= @height
    return true if j < 0 || j >= @width
    return true if @grid[i][j] == WALL
    false
  end

  def _is_beam(i, j)
    return false unless i >= 0 && i < @height
    return false unless j >= 0 && j < @width

    cell = @grid[i][j]
    cell == V_BEAM || cell == H_BEAM
  end
end
