#!/usr/bin/env ruby

def _random_word(len)
  (0...len).map { (65 + rand(26)).chr }.join
end

n = 100
puts n

n.times do
  t = rand(5) + 2
  puts t
  words = []
  t.times do
    words << _random_word(rand(10) + 1)
  end
  puts words.join(" ")
end
