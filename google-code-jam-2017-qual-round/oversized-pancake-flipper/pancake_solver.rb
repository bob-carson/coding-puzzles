class PancakeSolver
  def solve(pancakes, n)
    arr = pancakes.split("")
    runner = 0
    flips = 0

    while runner + n <= arr.length
      if arr[runner] == '-'
        flips += 1
        (runner...(runner+n)).each do |i|
          if arr[i] == '+'
            arr[i] = '-'
          else
            arr[i] = '+'
          end
        end
      end

      runner += 1
    end

    if arr.include?('-')
      return "IMPOSSIBLE"
    end

    flips
  end
end
