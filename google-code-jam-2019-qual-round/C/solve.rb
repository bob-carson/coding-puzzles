#!/usr/bin/env ruby

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

class Solver
  def solve(n, l, products)
    product_factors = products.map { |p| _factor(p) }

    factors = []

    if product_factors[1].include?(product_factors[0][0])
      factors << product_factors[0][1]
    else
      raise "expected #{product_factors[0][1]} to be a factor" unless product_factors[1].include?(product_factors[0][1])

      factors << product_factors[0][0]
    end
    (0...product_factors.length).each do |runner|
      if product_factors[runner][0] == factors.last
        puts "#{runner}, #{product_factors[runner]}: #{product_factors[runner][0]} == #{factors.last}, add #{product_factors[runner][1]}"
        factors << product_factors[runner][1]
      else
        raise "expected #{product_factors[runner][1]} to include last factor #{factors.last}" unless product_factors[runner][1] == factors.last
        puts "#{runner}, #{product_factors[runner]}: #{product_factors[runner][0]} != #{factors.last}, add #{product_factors[runner][0]}"
        factors << product_factors[runner][0]
      end
    end

    ordered_factors = factors.uniq.sort

    raise "Not enough factors" unless ordered_factors.length == 26

    factor_map = (0...26).map { |i| [ordered_factors[i], ("A".ord + i).chr]}.to_h

    puts "Map: #{products.map { |p| [p, *_factor(p)]}}"
    puts "factors: #{factors}"

    factors.map { |f| factor_map[f] }.join("")
  end

  def _factor(product)
    f1 = FactorFinder.factor(product)

    [f1, product/f1]
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  products = lines.shift.split(" ").map(&:to_i)
  value = Solver.new.solve(inputs[0], inputs[1], products)
  puts "Case \##{index + 1}: #{value}"
end
