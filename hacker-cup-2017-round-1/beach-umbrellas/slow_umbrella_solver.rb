class SlowUmbrellaSolver
  def self.solve(stands, radii)
    # puts "#{stands}, #{radii}"
    permutations(stands, Float::INFINITY, radii) % 1000000007
  end

  private

  def self.permutations(stands, left_open, radii)
    return 0 if stands <= 0

    if radii.count == 1
      permutations_for_single(stands, left_open, radii.first)
    else
      permutations_for_multiple(stands, left_open, radii)
    end
  end

  def self.permutations_for_multiple(stands, left_open, radii)
    permutations_with_umbrella_here = radii.each_with_index.map do |r,i|
      if r <= left_open
        new_radii = radii.clone
        new_radii.delete_at(i)

        stands_left = stands - r
        stands_left <= 0 ? 0 : permutations(stands_left, 0, new_radii)
      else
        0
      end
    end.inject(&:+)

    permutations_with_umbrella_here + permutations(stands - 1, left_open + 1, radii)

    # .tap do |x|
    #   puts "#{stands}, #{left_open}, #{radii}"
    #   puts "answer: #{x}"
    # end
  end

  def self.permutations_for_single(stands, left_open, radius)
    if left_open < radius
      [0, stands + left_open - radius].max
    else
      stands
    end
  end
end
