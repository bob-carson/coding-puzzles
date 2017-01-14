class ZombieSolver
  def self.solve(health, spells)
    parsed_spells = spells.map { |s| parse_spell(s) }
    probabilities = parsed_spells.map { |s| probability_to_kill(s, health) }
    '%.6f' % probabilities.max
  end

  private

  def self.parse_spell(spell)
    regex_match = /([0-9]+)d([0-9]+)(.*)/.match(spell)
    [regex_match[1].to_i, regex_match[2].to_i, regex_match[3].to_i]
  end

  def self.probability_to_kill(spell, health)
    probs = spell_probabilities(spell)

    probs.inject(0) do |sum, pair|
      pair[0] >= health ? sum + pair[1] : sum
    end
  end

  def self.spell_probabilities(spell)
    probabilities = { spell[2] => 1.0 }
    spell[0].times do
      new_probabilities = {}
      roll_prob = 1.0 / spell[1]

      (1..spell[1]).each do |roll|
        probabilities.each do |total, prob|
          new_total = total + roll
          if new_probabilities[new_total].nil?
            new_probabilities[new_total] = 0
          end
          new_probabilities[new_total] += prob * roll_prob
        end
      end

      probabilities = new_probabilities
    end

    probabilities
  end
end
