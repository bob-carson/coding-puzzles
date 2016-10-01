class FreeformSolver
  def solve(grid)
    # p "grid #{grid}"

    groups = (0...grid.count).map { |i| [i] }

    grid.each do |row|
      known_indexs = row.each_index.select { |i| row[i] == 1 }
      new_group = []
      known_indexs.each do |index|
        # p "groups: #{groups}"
        group_containing = groups.find { |group| group.include?(index) }

        if group_containing
          groups.delete(group_containing)
          new_group << group_containing
        end
      end
      if new_group.count > 0
        groups << new_group.flatten
      end
    end

    groups_to_combine = groups.map do |group|
      pretrained_rows = grid.each_index.select do |row_index|
        group.any? { |column| grid[row_index][column] == 1 }
      end

      if pretrained_rows.count > group.size
        [group, pretrained_rows.count]
      end


      # cost = 0
      # #fully train
      # cost += (group.size - pretrained_rows.size) * group.size
      # pretrained_rows.each do |row_index|
      #   group.each do |column|
      #     if grid[row_index][column] == 0
      #       cost += 1
      #     end
      #   end
      # end
      # cost
    end.compact

    # p "groups_to_combine : #{groups_to_combine}"

    groups_to_combine.each do |group, pretrained_rows|
      next unless groups.include?(group)

      left = pretrained_rows - group.count
      to_combine = []
      while left > 0
        p "left: #{left}"
        this_one = groups.select { |g| group != g && g.size <= left }.max { |g| g.count }
        if this_one.nil?
          this_one = groups.select { |g| group != g }.min { |g| g.count  }
        end
        # this_one = groups.find { |g| group != g && g.size == the_max }
        groups.delete(this_one)
        to_combine << this_one
        p "this_one: #{this_one}"
        left -= this_one.size
      end
      to_combine.flatten!

      groups.delete(group)
      groups << [*group, *to_combine]
    end
        # p "groups: #{groups}"

    costs = groups.map do |group|
      pretrained_rows = grid.each_index.select do |row_index|
        group.any? { |column| grid[row_index][column] == 1 }
      end

      cost = 0
      #fully train
      cost += (group.size - pretrained_rows.size) * group.size
      pretrained_rows.each do |row_index|
        group.each do |column|
          if grid[row_index][column] == 0
            cost += 1
          end
        end
      end
      cost
    end

    costs.inject(0) { |a,e| a+e }
  end
end
