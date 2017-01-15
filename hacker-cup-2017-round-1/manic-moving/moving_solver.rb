class MovingSolver
  def initialize
    @cost_cache = {}
    @dij_cache = {}
  end

  def solve(num_towns, paths, families)
    @path_matrix = to_matrix(num_towns, paths)
    @num_towns = num_towns
    @families = families
    # puts "#{@path_matrix[1..num_towns].map { |r| r[1..num_towns] }}"
    # dij(1, num_towns)[1..num_towns]

    value = cost(-1, -1, 1)
    if value == Float::INFINITY
      value = -1
    end
    value
  end

  private

  def cost(last_pickup, last_dropoff, current_location)
    key = [last_pickup, last_dropoff, current_location]

    return @cost_cache[key] if @cost_cache[key]

    @cost_cache[key] = calculate_cost(last_pickup, last_dropoff, current_location)
  end

  def calculate_cost(last_pickup, last_dropoff, current_location)
    return 0 if last_dropoff == @families.count - 1

    if last_pickup - last_dropoff == 0
      pickup_cost(last_pickup, last_dropoff, current_location)
    elsif last_pickup - last_dropoff == 2
      dropoff_cost(last_pickup, last_dropoff, current_location)
    else
      [pickup_cost(last_pickup, last_dropoff, current_location), dropoff_cost(last_pickup, last_dropoff, current_location)].min
    end
  end

  def pickup_cost(last_pickup, last_dropoff, current_location)
    next_pickup = last_pickup + 1
    return Float::INFINITY if @families.count <= next_pickup

    dist = distance(current_location, @families[next_pickup][0])
    return Float::INFINITY if dist == Float::INFINITY

    dist + cost(next_pickup, last_dropoff, @families[next_pickup][0])
  end

  def dropoff_cost(last_pickup, last_dropoff, current_location)
    next_dropoff = last_dropoff + 1
    dist = distance(current_location, @families[next_dropoff][1])
    return Float::INFINITY if dist == Float::INFINITY
    dist + cost(last_pickup, next_dropoff, @families[next_dropoff][1])
  end

  def distance(from_town, to_town)
    if @dij_cache[from_town]
      @dij_cache[from_town][to_town]
    elsif @dij_cache[to_town]
      @dij_cache[to_town][from_town]
    else
      @dij_cache[from_town] = dij(from_town)
      @dij_cache[from_town][to_town]
    end
  end

  def dij(from_town)
    vertices = (1..@num_towns).to_a
    distances = @path_matrix[from_town].dup

    while vertices.count > 0
      next_node = vertices.min_by { |u| distances[u] }
      vertices.delete(next_node)

      @path_matrix[next_node].each_with_index do |distance, index|
        new_distance = distance + distances[next_node]
        if distances[index] > new_distance
          distances[index] = new_distance
        end
      end
    end

    distances
  end

  def to_matrix(num_towns, paths)
    matrix = (0..num_towns).each.map { |n| Array.new(num_towns + 1, Float::INFINITY) }
    (1..num_towns).each do |n|
      matrix[n][n] = 0
    end

    paths.each do |path|
      a = path[0]
      b = path[1]
      if matrix[a][b] > path[2]
        matrix[a][b] = path[2]
        matrix[b][a] = path[2]
      end
    end

    matrix
  end
end
