#!/usr/bin/env ruby

class Solver
  def solve(p, cookies)
    w = cookies[0][0].to_f
    h = cookies[0][1].to_f
    min_per_cookie = 2 * (w + h)
    max_per_cookie = 2 * Math.sqrt(w * w + h * h) + min_per_cookie
    max = max_per_cookie * cookies.count

    increment = 2 * Math.sqrt(w * w + h * h)

    count = 0
    ans = min_per_cookie * cookies.count

    while count < cookies.count
      break if ans + increment > p

      ans += increment
      count += 1
    end

    # puts "w #{w} h #{h} sqrt #{Math.sqrt(w * w + h * h)} mpc #{max_per_cookie}"
    # ans = [p, max].min.to_f
    "#{'%.6f' % ans}"
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  cookies = []
  inputs[0].times do
    cookies << lines.shift.split(" ").map { |n| n.to_i }
  end
  value = Solver.new.solve(inputs[1], cookies)
  puts "Case \##{index + 1}: #{value}"
end
