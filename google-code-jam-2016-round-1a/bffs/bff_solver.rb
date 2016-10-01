class BffSolver
  def initialize
    @orphan_info = {}
  end

  def solve(kids)
    kids_hash = {}
    kids.each_with_index { |val, index| kids_hash[index + 1] = val }
    circles = _max_circles(kids_hash)
    max_line = _largest_line(kids_hash, circles)
    max_circle = _biggest_circle(circles)
    # p max_circle
    # p max_line
    # p "Max circle: #{@max_circles}"
    # p "pairs: #{@pairs}"
    # p "orphans: #{@orphans}"
    # p "nonorphans: #{@non_orphans}"
    # p @orphan_info
    max_circle > max_line ? max_circle : max_line
  end

  def _biggest_circle(max_circles)
    max_circles.map { |k,v| v }.max
  end

  def _largest_line(kids, max_circles)
    return -1 if _pairs(kids, max_circles).empty?
    _pair_sizes(kids, max_circles).inject(0) { |a,e| a+e }
  end

  def _pair_sizes(kids, max_circles)
    _pairs(kids, max_circles).map do |pair|
      chain1 = _max_orphan_chain(kids, pair[0])
      chain2 = _max_orphan_chain(kids, pair[1])
      chain1 + chain2 + 2
    end
  end

  def _max_orphan_chain(kids, kid)
    max = 0
    _orphans(@max_circles).each do |o|
      info = _orphan_info(kids, o, _nonorphans(@max_circles))
      if info[0] == kid && info[1] > max
        max = info[1]
      end
    end
    max
  end

  def _pairs(kids, max_circles)
    return @pairs if @pairs

    pairs = []
    paired_kids = _paired_kids(max_circles)
    while paired_kids.count > 0
      k1 = paired_kids.shift
      k2 = kids[k1]
      paired_kids.delete(k2)
      pairs << [k1, k2]
    end
    @pairs = pairs
  end

  def _paired_kids(max_circles)
    result = []
    max_circles.each do |kid, value|
      if value == 2
        result << kid
      end
    end
    result
  end

  def _nonorphans(max_circles)
    return @non_orphans if @non_orphans

    result = []
    max_circles.each do |kid, value|
      if value != -1
        result << kid
      end
    end
    @non_orphans = result
  end

  def _orphans(max_circles)
    return @orphans if @orphans
    result = []
    max_circles.each do |kid, value|
      if value == -1
        result << kid
      end
    end
    @orphans = result
  end

  def _orphan_info(kids, kid, non_orphans)
    return @orphan_info[kid] if @orphan_info[kid]

    if non_orphans.include?(kids[kid])
      @orphan_info[kid] = [kids[kid], 1]
    else
      pointing_to = _orphan_info(kids, kids[kid], non_orphans)
      @orphan_info[kid] = [pointing_to[0], pointing_to[1] + 1]
    end
  end


  def _longest_chain_to(kids, kid, orphans)
    distance = {}
    orphans.each { |o| distnace[o] = kids.length}
  end

  def _max_circles(kids)
    return @max_circles if @max_circles

    @max_circles = ((1..kids.length).map do |n|
      [n, _largest_circle(kids, n)]
    end.to_h)
  end

  def _largest_circle(kids, start)
    visited = []
    nxt = start
    while !visited.include?(nxt) do
      visited << nxt
      nxt = kids[nxt]
    end
    nxt == start ? visited.length : -1
  end

end
