#!/usr/bin/env ruby

class Solver
  def solve(a)
    if a == 999999995
      _problem_set_1
    else
      _problem_set_2(a)
    end

  end

  def _problem_set_2(a)
    _find_x
  end

  def _find_x
    increment = 25
    value = 50
    while increment > 1
      _put_err("value #{value} increment #{increment}")
      guess = "#{value} #{0}"
      STDOUT.puts(guess)
      STDOUT.flush

      feedback = STDIN.gets
      _put_err(feedback)
      if feedback.start_with?("MISS")
        value += increment
      else
        value -= increment
      end

      increment = (increment / 2.0).ceil
    end

    _put_err("value #{value} increment #{increment}")
    guess = "#{value} #{0}"
    STDOUT.puts(guess)
    STDOUT.flush

    feedback = STDIN.gets
    _put_err(feedback)
    if feedback.start_with?("MISS")
      value += increment
    else
      value -= increment
    end

    value
  end

  def _problem_set_1
    (-5..5).each do |x|
      (-5..5).each do |y|
        guess = "#{x} #{y}"
        STDOUT.puts(guess)
        STDOUT.flush

        feedback = STDIN.gets

        return if feedback.start_with?("CENTER")
        raise "Wrong answer #{feedback}" unless feedback.start_with?("MISS") || feedback.start_with?("HIT")
      end
    end
  end

  def _put_err(string)
    STDERR.puts(string)
  end
end

inputs = STDIN.gets.split(" ").map(&:to_i)
number_of_cases = inputs[0]
a = inputs[1]

number_of_cases.times do |index|
  value = Solver.new.solve(a)
end
