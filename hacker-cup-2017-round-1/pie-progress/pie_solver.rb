class PieSolver
  def self.solve(pies_by_day)
    pies_per_day = pies_by_day.first.count
    days = pies_by_day.count
    pies_by_day.each(&:sort!)

    (1..days).map do |n|
      eat_pie(n, pies_per_day, pies_by_day)
    end.inject(&:+)
  end

  private

  def self.eat_pie(day, pies_per_day, pies_by_day)
    day_to_eat = pies_by_day.first(day).min_by do |pies|
      cost_to_eat(pies_per_day, pies)
    end

    cost_to_eat(pies_per_day, day_to_eat).tap do |_cost|
      day_to_eat.shift
    end
  end

  def self.cost_to_eat(pies_per_day, pies)
    return Float::INFINITY if pies.count == 0
    n = pies_per_day - pies.count + 1
    pies.first + (n ** 2) - ((n - 1) ** 2)
  end
end
