require('./combinametrics.rb')

class UmbrellaSolver
  def self.solve(stands, radii)
    # puts "#{stands}, #{radii}"
    permutations(stands, radii) % 1000000007
  end

  def self.permutations(stands, radii)
    return stands if radii.count == 1

    total_space = radii.inject(&:+) * 2
    k = radii.count + 1

    radii.combination(2).map do |pair|
      space = total_space - (pair[0] + pair[1])

      n = stands - space - 1
      # puts "#{n}"
      if n < 0
        0
      else
        # puts "weak combs: #{Combinametrics.choose(n + k - 1, k - 1)} fact: #{Combinametrics.factorial(radii.count - 2)}"
        Combinametrics.choose(n + k - 1, k - 1)
      end
    end.inject(&:+) * Combinametrics.factorial(radii.count - 2) * 2
  end
end
