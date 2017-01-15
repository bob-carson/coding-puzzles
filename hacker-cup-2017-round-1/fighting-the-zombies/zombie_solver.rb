class ZombieSolver
  def self.solve(r, zombies)
    [r, zombies]
  end

  private

  def self.best_box(index, r, zombies)
    zombie = zombies[index]

    min_y = (0..r).map do |i|
      zombies_in_box(zombie[0] + i, zombie[1], r, zombies)
    end.max
    max_y = (0..r).map do |i|
      zombies_in_box(zombie[0] + i, zombie[1] + r, r, zombies)
    end.max
    min_x = (0..r).map do |i|
      zombies_in_box(zombie[0], zombie[1] + i, r, zombies)
    end.max
    max_x = (0..r).map do |i|
      zombies_in_box(zombie[0] + r, zombie[1] + i, r, zombies)
    end.max

    [min_x, max_x, min_y, max_y].max
  end

  def self.zombies_in_box(x, y, r, zombies)
  end
end
