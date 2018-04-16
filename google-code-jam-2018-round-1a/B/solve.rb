#!/usr/bin/env ruby

require 'bigdecimal'

INF = BigDecimal.new("30_000_000_000")

class Solver
  def solve(r, b, cashiers)
    # puts "r #{r} b #{b} cashiers #{cashiers.map { |c| c.map(&:to_i) }}"
    bits_left = b
    robots_left = r

    cashier_bits = Array.new(cashiers.count, BigDecimal.new(0))

    while bits_left > 0

      next_length = next_length(cashier_bits, cashiers)
      min = INF
      min_index = -1
            # puts "next_length #{next_length.map(&:to_i)}"
      next_length.each_with_index do |length, index|
        next if length == nil
        next if robots_left == 0 && cashier_bits[index] == 0

        if length < min
          min = length
          min_index = index
        end
      end

      if robots_left == 0
        if min_index == -1
          max = 0
          max_index = -1

          cashiers.each_with_index do |cashier, index|
            length = cost_for_bits(cashiers, index, cashier_bits[index])
            # puts "length #{length} index #{index}"

            if length > max
              max = length
              max_index = index
            end
          end

          temp = []
          cashier_bits.each_with_index do |bits, index|
            if bits == 0
              cost = cost_for_bits(cashiers, index, cashier_bits[max_index] + 1)

              temp << cost
            else
              temp << INF
            end
          end

          min = temp.min

          min_index = temp.index(min)
          cashier_bits[min_index] = cashier_bits[max_index] + 1
          cashier_bits[max_index] = 0
            # puts "replacing for max #{max_index} with #{min_index}"
            #     puts "cashier_bits #{cashier_bits.map(&:to_i)}"
        else
          temp = []
          cashier_bits.each_with_index do |bits, index|
            if bits == 0
              cost = cost_for_bits(cashiers, index, cashier_bits[min_index] + 1)
              if cost < min
                temp << min - cost
                # puts "WE SHOULD REPLACE index #{index}"
              else
                temp << 0
              end
            else
              temp << 0
            end
          end

          max = temp.max
          # puts "temp #{temp}"

          if max == 0
            #Do the normal thing
            cashier_bits[min_index] += 1
          else
            max_index = temp.index(max)
            cashier_bits[max_index] = cashier_bits[min_index] + 1
            cashier_bits[min_index] = 0
              # puts "replacing for min #{min_index} with #{max_index}"
          end
        end
      else
        robots_left -= 1 if cashier_bits[min_index] == 0
        cashier_bits[min_index] += 1
      end

      bits_left -= 1
    end

    # puts "cashier_bits #{cashier_bits.map(&:to_i)}"


    # [r, b, cashiers.map { |c| c.map(&:to_i) }]
    max_length(cashier_bits, cashiers).to_i
  end

  def cost_for_bits(cashiers, index, bits)
    return 0 if bits == 0
    return INF if bits > cashiers[index][0]
    cashiers[index][1] * bits + cashiers[index][2]
  end

  def next_length(cashier_bits, cashiers)
    costs = []
    cashiers.each_with_index do |cashier, index|
      if cashier_bits[index] == cashier[0]
        cost = nil
      else
        cost = cost_for_bits(cashiers, index, cashier_bits[index] + 1)
      end

      costs << cost
    end
    costs
  end

  def max_length(cashier_bits, cashiers)
    max = 0
    cashiers.each_with_index do |cashier, index|
      if cashier_bits[index] != 0
        length = cashier[1] * (cashier_bits[index]) + cashier[2]
        max = length if length > max
      end
    end
    max
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  inputs = lines.shift.split(" ").map(&:to_i)
  cashiers = []
  inputs[2].times do
    cashiers << lines.shift.split(" ").map { |n| BigDecimal.new(n) }
  end
  value = Solver.new.solve(inputs[0], inputs[1], cashiers)
  puts "Case \##{index + 1}: #{value}"
end
