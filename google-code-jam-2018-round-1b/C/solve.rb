#!/usr/bin/env ruby

# require 'bigdecimal'

class Solver
  def solve(recipes_in, vault)
    recipes = recipes_in.each_with_index.map do |r, index|
      [r[0] - 1, r[1] - 1, index] #unless r[0] == 1 || r[1] == 1
    end

    continue = true

    while continue
      continue = attempt_to_make(0, [], recipes, vault)
      # puts "vault #{vault}"
    end

    # puts "#{max_recipe_output(recipes[0], vault)}"

    vault[0]
  end

  def attempt_to_make(metal, upstream_metals, recipes, vault)
    recipe = recipes[metal]

    return false if upstream_metals.include?(recipe[0]) || upstream_metals.include?(recipe[1])

    if vault[recipe[0]] != 0 && vault[recipe[1]] != 0
      make_recipe!(recipes[metal], 1, vault)
      return true
    elsif vault[recipe[0]] == 0
      result = attempt_to_make(recipe[0], upstream_metals + [metal], recipes, vault)

      if result
        attempt_to_make(metal, upstream_metals, recipes, vault)
      else
        return false
      end
    else # vault[recipe[1]] == 0
      result = attempt_to_make(recipe[1], upstream_metals + [metal], recipes, vault)

      if result
        attempt_to_make(metal, upstream_metals, recipes, vault)
      else
        return false
      end
    end
  end

  # def can_make_more?(metal, upstream_metals, recipes, vault)
  #   recipe = recipes[metal]
  #   return false if upstream_metals.include?(recipe[0]) || upstream_metals.include?(recipe[1])
  #   return false if vault[recipe[0]] == 0 && !can_make_more?(recipe[0], upstream_metals + [metal], recipes, vault)
  #   next_vault = vault[recipe[0]] == 0 ? recipe_output(recipes[recipe[0]], 1, vault) : vault
  #   return false if vault[recipe[1]] == 0 && !can_make_more?(recipe[1], upstream_metals + [metal], recipes, next_vault)
  #
  #   true
  # end
  #
  # def max_recipe_output(recipe, vault)
  #   raise "bad recipe" if recipe[0] == 0 || recipe[1] == 0
  #   # return vault if recipe[0] == 0 || recipe[1] == 0
  #
  #   ing_1 = vault[recipe[0]]
  #   ing_2 = vault[recipe[1]]
  #
  #   amount = [ing_1, ing_2].min
  #
  #   recipe_output(recipe, amount, vault)
  # end
  #
  # def recipe_output(recipe, amount, original_vault)
  #   raise "not enough metal" if original_vault[recipe[0]] < amount || original_vault[recipe[1]] < amount
  #
  #   vault = original_vault.dup
  #
  #   vault[recipe[2]] += amount
  #   vault[recipe[0]] -= amount
  #   vault[recipe[1]] -= amount
  #
  #   vault
  # end

  def make_recipe!(recipe, amount, vault)
    raise "not enough metal" if vault[recipe[0]] < amount || vault[recipe[1]] < amount

    vault[recipe[2]] += amount
    vault[recipe[0]] -= amount
    vault[recipe[1]] -= amount

    vault
  end
end

lines = STDIN.read.split("\n")
number_of_cases = lines.shift.to_i

number_of_cases.times do |index|
  m = lines.shift.to_i
  recipes = []
  m.times do
    recipes << lines.shift.split(" ").map(&:to_i)
  end
  vault = lines.shift.split(" ").map(&:to_i)
  value = Solver.new.solve(recipes, vault)
  puts "Case \##{index + 1}: #{value}"
end
