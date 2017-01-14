class Combinametrics
  def self.choose(n, k)
    return choose(n, n - k) if k > n / 2
    return 1 if k == 0
    (n * choose(n - 1, k - 1)) / k
  end
end
