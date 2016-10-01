class DataSolver
  def self.solve(x, sizes)
    p "-------"
    sizes.sort!

    num_discs = 0

    while sizes.count > 0
      p "num_discs: #{num_discs}  sizes: #{sizes}"
      first_file = sizes.pop
      will_fit = sizes.select { |i| i <= x - first_file }
      if will_fit.count > 0
        sizes.delete(will_fit.max)
      end
      num_discs += 1
    end

    num_discs
  end
end
