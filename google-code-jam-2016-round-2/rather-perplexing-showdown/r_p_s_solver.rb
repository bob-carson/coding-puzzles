class RPSSolver
  def self.solve(rounds, rocks, papers, scissors)
    next_round = [rocks, papers, scissors]
    while !next_round.nil? && next_round.inject(0) { |a,e| a+e } > 1
      next_round = reduce_round(next_round)
    end

    return "IMPOSSIBLE" if next_round.nil?

    output_rounds = 0
    next_out = if next_round[0] == 1
      ["R"]
    elsif next_round[1] == 1
      ["P"]
    elsif next_round[2] == 1
      ["S"]
    else
      throw
    end

    while output_rounds < rounds
      next_out = output_next_round(next_out)
      output_rounds += 1
    end

    alphabetize(next_out)
  end

  def self.output_next_round(output)
    new_out = []
    output.each do |o|
      if o == "P"
        new_out << "P"
        new_out << "R"
      elsif o == "S"
        new_out << "P"
        new_out << "S"
      elsif o == "R"
        new_out << "R"
        new_out << "S"
      else
        throw
      end
    end
    new_out
  end

  def self.alphabetize(output)
    o = output
    while o.count > 1
      o = alphabetize_next(o)
    end
    o.first
  end

  def self.alphabetize_next(arr)
    return arr if arr.size <= 1

    pairs = []
    (0...arr.count/2).each do |i|
      try1 = "#{arr[i * 2]}#{arr[i * 2 + 1]}"
      try2 = "#{arr[i * 2 + 1]}#{arr[i * 2]}"
      pairs << [try1, try2].min
    end
    pairs
  end

  def self.reduce_round(round)
    rocks = round[0]
    papers = round[1]
    scissors = round[2]
    round = [(rocks + scissors - papers) / 2, (rocks + papers - scissors) / 2, (scissors + papers - rocks) / 2]
    if round.any? { |i| i < 0 || i % 1 != 0}
      nil
    else
      round
    end
  end
end
