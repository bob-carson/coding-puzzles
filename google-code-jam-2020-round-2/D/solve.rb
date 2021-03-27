#!/usr/bin/env ruby

class Solver
  def solve(p, l_arr, r_arr, p_arr, s_arr, e_arr)
    parens = _match_parens(p)

    cache = {}

    # puts "s len #{s_arr.length} e len #{e_arr.length}"
    lengths = (0...s_arr.length).map do |index|
      _shortest_path(s_arr[index], e_arr[index], parens, l_arr, r_arr, p_arr, cache).tap do |ans|
        # puts "!! distance #{ans}"
      end
    end

    lengths.inject(0) { |sum,x| sum + x }
  end

  def _shortest_path(s, e, parens, l, r, p, cache)
    return 0 if s == e
    # puts "********** shortest #{s} #{e}"
    start = s - 1
    goal = e - 1

    unvisited = nil
    distance = nil
    next_node = nil

    if cache[start]
      unvisited = cache[start][:unvisited]
      distance = cache[start][:distance]
      next_node = cache[start][:next_node]

      if next_node == goal || !unvisited.include?(goal)
        return distance[goal]
      end
    else
      distance = Array.new(l.length) { Float::INFINITY }
      distance[start] = 0

      unvisited = (0...l.length).to_a

      next_node = start
    end

    while next_node != nil
      neighbors = _get_neighbors(next_node, parens, l, r, p)
      # puts "neighbors node #{next_node}, #{neighbors}"
      # puts "distance #{distance}"
      # puts "unvisited #{unvisited}"

      neighbors.each do |n|
        if distance[next_node] + n[1] < distance[n[0]]
          distance[n[0]] = distance[next_node] + n[1]
        end
      end

      unvisited.delete(next_node)
      next_node_index = unvisited.map { |i| distance[i] }.each_with_index.min
      next_node = unvisited[next_node_index[1]]

      break if next_node == goal
    end

    cache[start] = {
      :unvisited => unvisited,
      :next_node => next_node,
      :distance => distance,
    }

    distance[goal]
  end

  def _get_neighbors(node, parens, l, r, p)
    ret = []

    ret << [node - 1, l[node]] if node > 0
    ret << [node + 1, r[node]] if node < r.length - 1
    ret << [_matching(node, parens), p[node]]

    ret
  end

  def _matching(node, parens)
    open_index = parens[0].find_index(node)

    unless open_index.nil?
      parens[1][open_index]
    else
      closed_index = parens[1].find_index(node)

      parens[0][closed_index]
    end
  end

  def _match_parens(p)
    runner = 0
    open = []
    closed = []
    while runner < p.length
      if p[runner] == '('
        open << runner
        closed << nil
      else
        raise "expected ) at #{runner}" unless p[runner] == ')'
        j = -1
        while closed[j] != nil
          j -= 1
          raise "infinite loop runner #{runner}" if j < -1 * p.length
        end
        closed[j] = runner
      end
      runner += 1
    end
    [open, closed]
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  k,q = lines.shift.split(" ").map(&:to_i)
  p = lines.shift
  l_arr = lines.shift.split(" ").map(&:to_i)
  r_arr = lines.shift.split(" ").map(&:to_i)
  p_arr = lines.shift.split(" ").map(&:to_i)
  s_arr = lines.shift.split(" ").map(&:to_i)
  e_arr = lines.shift.split(" ").map(&:to_i)
  out = Solver.new.solve(p, l_arr, r_arr, p_arr, s_arr, e_arr)
  puts "Case \##{index + 1}: #{out}"
end

# puts (0..100).map { rand(12) + 1 }.join(" ")
# puts (0..100).map { rand(12) + 1 }.join(" ")
