require "./fractile_generator.rb"

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
    return [1] if original_length == 1

    rows_with_lead = _rows_with_lead_column(original_length, complexity)
    rows_with_lead.sort_by! { |r| r[1].length }

    return [rows_with_lead.first[0]] if rows_with_lead.first[1].length == 0

    number_possible_sequences = 2 ** original_length - 2
    rows_with_lead.combination(column_guesses).each do |combo|
      next if combo.map { |row| row[1].length }.inject(:+) > number_possible_sequences

      if combo.map { |row| row[1] }.inject(:&).length == 0
        return combo.map { |row| row[0] + 1 }
      end
    end
    return nil
  end

  # excludes all lead (and all gold) row
  def self._rows_with_lead_column(original_length, complexity)
    sequences = FractileGenerator.possible_sequences(original_length, complexity)
    sequences.shift
    sequences.pop

    result = []
    sequences.first.each_index do |i|
      rows_with_lead = []
      sequences.each_index do |j|
        if !sequences[j][i]
          rows_with_lead << j
        end
      end
      result << [i, rows_with_lead]
    end
    result
  end
end
