class RedTapeSolver


  def solve(k, probabilities)
    @probabilities = probabilities.sort!
    @k = k
    # p "input: #{k} #{probabilities}"

    last_guess = -1
    guess = k/2
    while guess > 0 && guess < k && last_guess != guess
      last_guess = guess
      if for_committe_with_break(guess + 1) > for_committe_with_break(guess)
        guess = guess + 1
      elsif for_committe_with_break(guess - 1) > for_committe_with_break(guess)
        guess = guess - 1
      end
    end

    for_committe_with_break(guess)
  end

  def for_committe_with_break(prob_break)
    @cache ||= {}

    if @cache[prob_break].nil?
      before_break = prob_break
      after_break = @k - prob_break
      @cache[prob_break] = for_committe([*@probabilities.first(before_break), *@probabilities.last(after_break)])
    end
    @cache[prob_break]
  end

  def for_committe(committee)
    k = committee.count
    # p "committee #{committee}"

    probs = (0..k-1).to_a.combination(k/2).map do |perm|
      prob = 1
      committee.each_index do |i|
        if perm.include?(i)
          prob *= committee[i]
        else
          prob *= 1 - committee[i]
        end
      end
      prob
    end
    # p "probs count #{probs.count}"

    probs.inject(0) { |a,e| a+e }
  end
end
