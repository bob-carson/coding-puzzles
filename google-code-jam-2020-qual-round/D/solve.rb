#!/usr/bin/env ruby

class Solver
  def initialize(b, std_in)
    @b = b
    @std_in = std_in
    @reversible = Array.new(b/2, nil)
    @current_data = Array.new(b, nil)
  end

  def solve
    @number_of_queries = 0
    @checked_reverse = true
    @checked_compliment = true

    while !_have_answer?

      if !@checked_compliment
        _put_err("checking complement")
        if @reversible.any? { |r| r == false }
          n = @reversible.find_index(false)
          response = _query(n + 1)
          if response != @current_data[n]
            _complement_data!
          end
        end
        @checked_compliment = true
      elsif !@checked_reverse
        _put_err("checking reverse")
        if @reversible.any? { |r| r == true }
          n = @reversible.find_index(true)
          response = _query(n + 1)
          if response != @current_data[n]
            @current_data.reverse!
          end
        end
        @checked_reverse = true
      else
        n = _next_query
        response = _query(n + 1)
        _put_err("response #{response}")
        @current_data[n] = response
        _put_err("current data #{@current_data.to_s}")
        _put_err("reversible #{@reversible.to_s}")

        _update_reversible!(n)
      end
    end

    _answer
  end

  def _next_query
    rev_index = @reversible.find_index(nil)
    return rev_index if @current_data[rev_index] == nil

    @b - (rev_index + 1)
  end

  def _update_reversible!(n)
    return if n <  @reversible.length

    reversed_index = @b - (n + 1)
    @reversible[reversed_index] = (@current_data[n] != @current_data[reversed_index])
  end

  def _have_answer?
    @current_data.none? { |d| d == nil }
  end

  def _query(n)
    @number_of_queries += 1
    if @number_of_queries % 10 == 0
      @checked_reverse = false
      @checked_compliment = false
    end

    raise "Too any queries" if @number_of_queries > 150

    _put_err("querying #{n}")
    STDOUT.puts(n)
    STDOUT.flush
    @std_in.gets.to_i.tap do |response|
      _put_err("response #{response.to_s}")
    end
  end

  def _answer
    answer = @current_data.join("")
    _put_err("answering #{answer}")
    STDOUT.puts(answer)
    STDOUT.flush
    feedback = @std_in.gets
    raise "Wrong answer, feedback: #{feedback}" unless feedback.start_with?("Y")
    _put_err("feedback #{feedback}")
  end

  def _complement_data!
    @current_data = @current_data.map do |i|
      if i == 0
        1
      elsif i == 1
        0
      elsif i != nil
        raise "Unexpected data"
      end
    end
  end

  def _put_err(string)
    # STDERR.puts(string)
  end
end

input = STDIN.gets.split(" ").map(&:to_i)
number_of_cases = input[0]
b = input[1]

# STDERR.puts("number of cases #{number_of_cases}")
number_of_cases.times do |index|
  out = Solver.new(b, STDIN).solve
end
