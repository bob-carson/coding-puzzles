class FashionSolver
  def solve(n, models)
    @n = n
    @rows = Array.new(n)
    @columns = Array.new(n)
    @plus_diags = Array.new(2*n-1)
    @minus_diags = Array.new(2*n-1)

    score = 0

    models.each do |model|
      if model[0] == 'o'
        score += 2
      else
        score += 1
      end
      add_model(model)
    end

    new_models = []

    empty_rows = []
    @rows.each_index { |i| empty_rows << i if @rows[i].nil? }
    empty_columns = []
    @columns.each_index { |i| empty_columns << i if @columns[i].nil? }

    empty_pairs = empty_rows.zip(empty_columns)
    empty_pairs.each do |pair|
      if @plus_diags[pair[0] + pair[1]] && @plus_diags[pair[0] + pair[1]][1] == pair[0]+1 && @plus_diags[pair[0] + pair[1]][2] == pair[1]+1
        model = ['o', pair[0] + 1, pair[1] + 1]
      else
        model = ['x', pair[0] + 1, pair[1] + 1]
      end

      add_model(model)
      new_models << model
      score += 1
    end


    empty_plus = []
    @plus_diags.each_index { |i| empty_plus << i if @plus_diags[i].nil? }
    empty_minus = []
    @minus_diags.each_index { |i| empty_minus << i if @minus_diags[i].nil? }

    empty_plus.each do |plus_diag|
      eligible_minus = empty_minus.select do |minus_diag|
        inelig = [(n - plus_diag - 1), (plus_diag - n + 1)].max
        ((plus_diag - minus_diag) % 2) != @n % 2 && minus_diag >= inelig && minus_diag < (2 * n - inelig - 1)
      end

      minus_diag = eligible_minus.min_by { |minus_diag|
        [minus_diag, ((2*@n - 2) - minus_diag)].min
      }

      next if minus_diag.nil?

      row = (plus_diag + minus_diag - @n + 1) / 2
      column = plus_diag - row

      if @rows[row][2] == column+1
        new_models.delete(@rows[row])
        model = ['o', row + 1, column + 1]
      else
        model = ['+', row + 1, column + 1]
      end

      add_model(model)
      new_models << model
      empty_minus.delete(minus_diag)
      score += 1
    end

    # puts "rows #{@rows}"
    # puts "columns #{@columns}"
    # puts "plus_diags #{@plus_diags}"
    # puts "minus_diags #{@minus_diags}"
    # puts "new model #{new_models}"

    "#{score} #{new_models.count}\n#{new_models.map { |m| m.join(" ") }.join("\n")}"
  end

  def add_model(model)
    if model[0] == 'x' || model[0] == 'o'
      @rows[model[1] - 1] = model
      @columns[model[2] - 1] = model
    end
    if model[0] == '+' || model[0] == 'o'
      @plus_diags[plus_index(model)] = model
      @minus_diags[minus_index(model)] = model
    end
  end

  def plus_index(model)
    model[1] +  model[2] - 2
  end

  def minus_index(model)
    model[1] - model[2] + @n - 1
  end
end
