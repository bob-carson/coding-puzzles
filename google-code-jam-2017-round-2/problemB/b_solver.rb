class BSolver
  def solve(n, c, tickets)
    raise "not 2" if c != 2

    @customer_1 = tickets.select { |t| t[1] == 1 }.map { |t| t[0] }.sort
    @customer_2 = tickets.select { |t| t[1] == 2 }.map { |t| t[0] }.sort

    @c1_grouped = _grouped(@customer_1)
    @c2_grouped = _grouped(@customer_2)

    # puts "#{[@customer_1, @customer_2]}"

    _num_rides
    "#{@num_ride} #{_promos}"
  end

  def _grouped(customer)
    customer.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
  end

  def _mode(grouped)
    grouped.keys.max_by { |v| grouped[v] }
  end

  def _mode_count(grouped)
    return if grouped.empty?
    grouped[_mode(grouped)]
  end

  def _promos
    c1_mode = _mode(@c1_grouped)
    c2_mode = _mode(@c2_grouped)

    # puts "#{c1_mode} #{_mode_count(@customer_1)}"
    #     puts "#{c2_mode} #{_mode_count(@customer_2)}"
    # puts c2_mode

    candidates = [0]

    candidates << @c1_grouped[c1_mode] + @c2_grouped[c1_mode] - @num_ride
    candidates << @c1_grouped[c2_mode] + @c2_grouped[c2_mode] - @num_ride


    candidates.max
  end

  def _num_rides
    @num_ride ||= [_first_seats, @customer_1.count, @customer_2.count].max
  end

  def _first_seats
    @first_seats ||= @customer_1.count { |s| s == 1 } + @customer_2.count { |s| s == 1 }
  end
end
