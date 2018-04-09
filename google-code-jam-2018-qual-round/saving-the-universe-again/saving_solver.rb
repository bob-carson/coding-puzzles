class SavingSolver
  def solve(d, p)
    puts p
    characters = p.split("")

    return 0 if damage(characters) <= d

    hack_count = 0
    next_index = last_c_before_s_index(characters)

    while next_index != nil
      hack(characters, next_index)

      hack_count += 1

      return hack_count if damage(characters)<= d

      next_index = last_c_before_s_index(characters)
    end

    "IMPOSSIBLE"
  end

  def damage(array)
    damage = 0
    strength = 1

    array.each do |e|
      if e == "C"
        strength *= 2
      elsif e == "S"
        damage += strength
      else
        raise "bad letter"
      end
    end

    damage
  end

  def last_c_before_s_index(array)
    runner = array.count - 1

    while true
      return nil if runner == -1
      return runner if array[runner] == "C" && array[runner + 1] == "S"

      runner -= 1
    end
  end

  def hack(array, index)
    temp = array[index]
    array[index] = array[index + 1]
    array[index + 1] = temp
  end
end
