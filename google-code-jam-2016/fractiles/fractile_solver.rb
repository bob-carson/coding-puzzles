class FractileSolver
  def self.solve(original_length, complexity, column_guesses)
    value = _solve(original_length, complexity, column_guesses)
    if value
      value.join(" ")
    else
      "IMPOSSIBLE"
    end
  end

  # private

  def self._solve(original_length, complexity, column_guesses)
    return nil if original_length > complexity * column_guesses

    original_columns = (0...original_length).to_a
    result = []
    while original_columns.length > 0
      result << _index_for_original_indexs(original_columns.shift(complexity), original_length) + 1
    end
    result
  end

  def self._index_for_original_indexs(original_indexs, original_length)
    base = 1
    result = 0
    original_indexs.each do |i|
      result += base * i
      base *= original_length
    end
    result
  end
end
