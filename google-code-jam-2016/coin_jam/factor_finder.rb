require 'prime'

class FactorFinder
  def self.factor(n)
    if !_cache.has_key?(n)
      _cache[n] = _get_factor(n)
    end
    _cache[n]
  end

  # private

  def self._get_factor(n)
    Prime.each(Math.sqrt(n)).each do |i|
      if n % i == 0
        return i
      end
    end
    return nil
  end
  private_class_method :_get_factor

  def self._cache
    @cache ||= {}
  end
  private_class_method :_cache
end
