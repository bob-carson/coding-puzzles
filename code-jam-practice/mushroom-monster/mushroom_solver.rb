class MushroomSolver
  def self.solve(mushrooms)
    "#{_method_1(mushrooms)} #{_method_2(mushrooms)}"
  end

  private

  def self._method_1(mushrooms)
    eaten = (0...mushrooms.length - 1).map do |n|
      mushrooms[n] - mushrooms[n+1]
    end.map { |d| d > 0 ? d : 0 }
    eaten.inject(0) { |a,e| e + a }
  end

  def self._method_2(mushrooms)
    diffs = (0...mushrooms.length - 1).map do |n|
      mushrooms[n] - mushrooms[n+1]
    end
    rate = diffs.max
    mushrooms[0...-1].inject(0) {  |a,e| a + (e < rate ? e : rate) }
  end
end
