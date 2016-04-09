#!/usr/bin/env ruby

require 'set'

class PancakeSolver
  def initialize(pancakes)
    @length = pancakes.length
    @start = pancakes.freeze
    @visited = Set.new
  end

  def flips_until_happy
    flips = 0
    current_stacks = [@start]

    while true
      return flips if _contains_happy(current_stacks)
      flips += 1
      current_stacks.each { |s| @visited << s }

      next_stacks = Set.new
      current_stacks.each do |stack|
        (1..@length).each do |n|
          _flip_and_add(stack, n, next_stacks)
        end
      end
      current_stacks = next_stacks
    end
  end

  private

  def _contains_happy(stacks)
    stacks.any? { |s| !s.include?("-") }
  end

  def _flip_and_add(pancakes, count, next_stacks)
    flipped = _calculate_flip(pancakes, count)
    unless @visited.include?(flipped)
      next_stacks << flipped
    end
  end

  def _calculate_flip(pancakes, count)
    new_stack = pancakes.dup
    cakes_to_flip = new_stack[0, count]
    cakes_to_flip.reverse!
    cakes_to_flip.gsub!("-", "*")
    cakes_to_flip.gsub!("+", "-")
    cakes_to_flip.gsub!("*", "+")
    new_stack[0, count] = cakes_to_flip
    new_stack
  end
end


lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  pancakes = lines.shift
  value = PancakeSolver.new(pancakes).flips_until_happy
  puts "CASE \##{index + 1}: #{value}"
end
