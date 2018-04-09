#!/usr/bin/env ruby

def out(string)
  puts string
  STDOUT.flush
end

def err(string)
  # STDERR.puts string
  # STDERR.flush
end

def get_in
  STDIN.gets
end

class GolpherSolver
  def initialize(a)
    @a = a
    @steps = 0
    @side_length = Math.sqrt(a).ceil
    @soil = Array.new(@side_length) { Array.new(@side_length) { false } }

    @max_diag = (@side_length * 2) - 6
    @current_diag = 0
    @current_index = 0

    @on_last_square = false


    err "init #{@a} #{@side_length} max_diag #{@max_diag}"

    guess
  end

  def step(x, y)
    @steps += 1
    raise "too many tries" if @steps >= 1000
    raise "failure" if x == -1 && y == -1
    return true if x == 0 && y == 0

    err "step #{x} #{y}"

    @soil[x-1][y-1] = true

    guess

    false
  end

  def guess
    t = next_targets
    # set_ols = false
    while targets_covered?(t) && !@on_last_square
      if max_index?(@current_index, @current_diag)
        if @current_diag < @max_diag
          @current_diag += 1
          @current_index = [0, @current_diag - (@max_diag / 2)].max
          err "incrementing to #{@current_diag} #{@current_index}"

        else
          # set_ols = true
          @on_last_square = true
          err "skipping increment cur:#{@current_diag} max: #{@max_diag}"
        end
      else
        @current_index += 1
        err "incrementing to #{@current_diag} #{@current_index}"
      end

      t = next_targets
    end
      raise "foo #{t.to_s}" if @on_last_square

    err @soil.to_s

    g = guess_square
    err "guessing #{g[0]} #{g[1]}"
    out "#{g[0] + 1} #{g[1] + 1}"
  end

  def next_targets
    first_target = [@current_index, @current_diag - @current_index]
    targets = [first_target]

    if first_target[0] == 0
      err "--- first target x 0"
      targets << [@current_index, @current_diag - @current_index + 1]
      targets << [@current_index, @current_diag - @current_index + 2]
    end
    if first_target[1] == 0
      err "--- first target y 0"
      targets << [@current_index + 1, @current_diag - @current_index]
      targets << [@current_index + 2, @current_diag - @current_index]
    end
    if first_target[0] == @side_length - 3
      err "--- first target x end"
      targets << [@current_index + 1, @current_diag - @current_index]
      targets << [@current_index + 1, @current_diag - @current_index + 1]
      targets << [@current_index + 1, @current_diag - @current_index + 2]
      targets << [@current_index + 2, @current_diag - @current_index]
      targets << [@current_index + 2, @current_diag - @current_index + 1]
      targets << [@current_index + 2, @current_diag - @current_index + 2]
      err targets.to_s
    end
    if first_target[1] == @side_length - 3
      err "--- first target y end"
      targets << [@current_index, @current_diag - @current_index + 1]
      targets << [@current_index + 1, @current_diag - @current_index + 1]
      targets << [@current_index + 2, @current_diag - @current_index + 1]
      targets << [@current_index, @current_diag - @current_index + 2]
      targets << [@current_index + 1, @current_diag - @current_index + 2]
      targets << [@current_index + 2, @current_diag - @current_index + 2]
      err targets.to_s
    end

    targets
  end

  def targets_covered?(targets)
    targets.all? do |t|
      @soil[t[0]][t[1]]
    end
  end

  def guess_square
    [@current_index + 1, @current_diag - @current_index + 1]
  end

  def max_index?(index, diag)
    index >= ([diag, @max_diag / 2].min)
  end
end

line = get_in
number_of_cases = line.to_i

number_of_cases.times do |index|
  a = get_in.to_i
  solver = GolpherSolver.new(a)
  input_values = get_in.split(" ").map(&:to_i)
  while !solver.step(input_values[0], input_values[1])
    input_values = get_in.split(" ").map(&:to_i)
  end
end
