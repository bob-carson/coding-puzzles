class Combinametrics
  def self.choose(n, k)
    @choose_cache ||= {}
    key = [n,k]
    if @choose_cache[key]
      @choose_cache[key]
    else
      @choose_cache[key] = _calculate_choose(n, k)
    end
  end

  def self.factorial(n)
    @factorial_cache ||= {}
    if @factorial_cache[n]
      @factorial_cache[n]
    else
      @factorial_cache[n] = (1..n).inject(:*) || 1
    end
  end

  private

  def self._calculate_choose(n,k)
    return choose(n, n - k) if k > n / 2
    return 1 if k == 0
    (n * _calculate_choose(n - 1, k - 1)) / k
  end
  private_class_method :_calculate_choose
end
