class UpAndDownSolver
  def self.solve(sequence)
    swaps = 0
    sequences = [sequence]
    while true
      return swaps if sequences.any
    end
  end

  def self.reversable_candidate_solutions(sequence, directions)
    [*candidate_solutions(sequence, direction), *candidate_solutions(sequence.reverse, direction.reverse)].uniq
  end

  def self.candidate_solutions(sequence, directions)
    past_corner = false

    move_corner = nil
    fix_downhill = nil
    directions.each_with_index do |d, index|
      if !past_corner && d == -1
        move_corner = index + 1
        past_corner = true
      elsif past_corner && d == 1
        fix_downhill = index + 1
        break
      end
    end

    [*_move_corner_candidates(move_corner, sequence, directions), *_fix_downhill_candidates(fix_downhill, sequence, directions)]
  end

  def self._move_corner_candidates(move_corner_index, sequence, directions)
    return [] if move_corner_index.nil?

    corner_value = sequence[move_corner_index]
    new_sequences = sequence.each_index.select { |i| i > move_corner_index && sequence[i] > corner_value}.map do |swap_index|
      new_seq = sequence.dup
      new_seq[move_corner_index] = sequence[swap_index]
      new_seq[swap_index] = corner_value
      new_seq
    end
  end

  def self._fix_downhill_candidates(fix_downhill_index, sequence, directions)
    return [] if fix_downhill_index.nil?

    downhill_value = sequence[fix_downhill_index]
    new_sequences = sequence.each_index.select { |i| i > fix_downhill_index && sequence[i] > downhill_value}.map do |swap_index|
      new_seq = sequence.dup
      new_seq[fix_downhill_index] = sequence[swap_index]
      new_seq[swap_index] = downhill_value
      new_seq
    end
  end

  def self._direction(sequence)
    (0...sequence.count-1).map do |i|
      sequence[i] < sequence[i+1] ? 1 : -1
    end
  end

  def self._solved?(directions)
    past_corner = false
    directions.each do |d|
      if !past_corner && d == -1
        past_corner = true
      elsif past_corner && d == 1
        return false
      end
    end
    return true
  end
end
