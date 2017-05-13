class DragonSolver
  def solve(hd, ad, hk, ak, b, d)
    @cache = {}

    x = turns(hd, ad, hk, ak, b, d, hd, false)
    return "IMPOSSIBLE" if x == Float::INFINITY
    x
  end

  def turns(*args)
    if @cache[args]
      @cache[args]
    else
      # p "#{args}"

      @cache[args] = _turns(*args)
      @cache[args]
    end
  end

  def _turns(hd, ad, hk, ak, b, d, hp, cured)
    return 1 if ad >= hk

    options = []
    if hp > ak
      # p "att"
      options << [hd, ad, hk - ad, ak, b, d, hp - ak, false] # attack
      if b > 0
        # p "buff"
        options << [hd, ad + b, hk, ak, b, d, hp - ak, false] # buff
      end
    end
    if hd > ak && !cured
      # p "cure"
      options << [hd, ad, hk, ak, b, d, hd - ak, true] # cure
    end
    if hp > ak - d && ak > 0 && d > 0
      # p "debuff"
      options << [hd, ad, hk, [ak - d, 0].max, b, d, hp - [ak - d, 0].max, false] # debuff
    end

    options = options.map { |o| turns(*o) }

    return Float::INFINITY if options.empty?

    options.min + 1
  end
end
