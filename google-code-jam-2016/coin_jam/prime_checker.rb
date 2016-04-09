class PrimeChecker
  def self.prime?(n)
    if _cache[n] == nil
      _cache[n] = _check_prime(n)
    end
    _cache[n]
  end

  # private

  def self._check_prime(n)
    p n
    (2..Math.sqrt(n)).each do |i|
      if n % i == 0
        return false
      end
    end
    return true
  end
  private_class_method :_check_prime

  def self._cache
    @cache ||= {}
  end
  private_class_method :_cache
end
