class SabotageSolver
  def self.solve(n, m, k)
    short = [n, m].min
    long = [n, m].max

    answers = []
    if room_for_row?(short, long, k)
      answers << row_cost(short, long, k)
    end
    if room_for_corner?(short, long, k)
      answers << corner_cost(short, long, k)
    end

    answers.min || -1
  end

  private

  def self.room_for_row?(short, long, k)
    long >= ((2 * k) + 3) && short >= (k + 1)
  end

  def self.row_cost(short, long, k)
    (short.to_f / k).ceil
  end

  def self.room_for_corner?(short, long, k)
    long >= ((k * 2) + 3) && short >= ((k * 2) + 1)
  end

  def self.corner_cost(short, long, k)
    k == 1 ? 5 : 4
  end
end
