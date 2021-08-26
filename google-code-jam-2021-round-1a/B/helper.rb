#!/usr/bin/env ruby

require 'prime'

def nth_prime(n)
  prime_count = 0  #keeps track of how many primes we have so far
  current_num = 0  #current number

  while true
     if Prime.prime?(current_num)
        prime_count += 1
        if prime_count == n
           return current_num
        end
     end
     current_num += 1
  end
end

primes = (1..100).map { |i| nth_prime(i) }
puts "100\n"
100.times do
  n = rand(10)
  hash = {}
  n.times do
    adder = primes[rand(100)]
    raise "adder is nil" if adder == nil
    if hash[adder]
      hash[adder] += 1
    else
      hash[adder] = 1
    end
  end
  puts "#{hash.keys.count}\n"
  hash.each do |k,v|
    puts "#{k} #{v}\n"
  end
end
