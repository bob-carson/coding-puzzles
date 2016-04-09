require "./factor_finder.rb"

class CoinJamSolver
  def initialize(length)
    @length = length
    @permutation_enumerator = ["0", "1"].repeated_permutation(length - 2)
  end

  def next_possible_coin_jam
    bits = @permutation_enumerator.next
    "1#{bits.join}1"
  end

  def coin_jam_proof(coin_jam)
    result = [coin_jam]
    (2..10).each do |base|
      coin_in_base = _value_in_base(coin_jam, base)
      factor = FactorFinder.factor(coin_in_base)
      return nil unless factor
      result << factor
    end
    result
  end

  def find_coin_jams(number)
    result = []
    while result.length < number
      next_jam = next_possible_coin_jam
      proof = coin_jam_proof(next_jam)
      if proof
        result << proof
      end
    end
    result
  end

  private

  def _value_in_base(coin_jam, base)
    coin_jam.to_i(base)
  end
end
