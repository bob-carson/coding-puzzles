class FractileGenerator
  # order matters
  def self.possible_sequences(original_length, complexity)
    [true, false].repeated_permutation(original_length).map do |original|
      _sequence_with_complexity(complexity, original)
    end
  end

  def self.visualize(arr)
    arr.inject("") { |o,e| o + (e ? "G" : "L") }
  end

  # private

  def self._sequence_with_complexity(complexity, original)
    return original if complexity == 1
    if _cache[[complexity, original]] == nil
      _cache[[complexity, original]] = _calculate_sequence(complexity, original)
    end
    _cache[[complexity, original]]
  end

  def self._calculate_sequence(complexity, original)
    original_length = original.length
    _sequence_with_complexity(complexity - 1, original).flat_map do |element|
      element ? Array.new(original_length, true) : original
    end
  end

  def self._cache
    @cache ||= {}
  end
end
