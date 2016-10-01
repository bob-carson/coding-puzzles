class TechnoBabbleSolver
  def initialize(topics)
    @topics = topics
    @first_words = []
    @seconds_words = []
    @fakes = 0
    @counted_topics = []
  end

  def solve
    @topics.each do |topic|
      _add_topic(topic)
    end
    @fakes
  end


  def _add_topic(topic)
    if @first_words.include?(topic[0]) && @seconds_words.include?(topic[1])
      _handle_double(topic)
    elsif !@first_words.include?(topic[0]) && !@seconds_words.include?(topic[1])
      @first_words << topic[0]
      @seconds_words << topic[1]
    else
      _handle_mixed(topic)
    end
    @counted_topics << topic
  end

  def _handle_double(topic)
    @fakes += 1
    if _has_unconnected_double_duplicates?(topic)
      p "Adding 2 on #{topic}"
      @fakes += 1
    end
  end

  def _handle_mixed(topic)
    if @first_words.include?(topic[0])
      if _has_duplicate_other_half?(topic, 0, 1)
        p "Fake single on #{topic}"
        @fakes += 1
      end
      @seconds_words << topic[1]
    else
      if _has_duplicate_other_half?(topic, 1, 0)
        p "Fake single on #{topic}"
        @fakes += 1
      end
      @first_words << topic[0]
    end
  end

  def _has_duplicate_other_half?(topic, included_index, unincluded_index)
    @counted_topics.select { |t| t[included_index] == topic[included_index] }.any? do |t|
      _frequency(@counted_topics, unincluded_index)[t[unincluded_index]] > 1
    end
  end

  def _has_unconnected_double_duplicates?(topic)
    first_connected_words = _connected_duplicate_words(topic, 1, 0)
    second_connected_words = _connected_duplicate_words(topic, 0, 1)

    return false if first_connected_words.count == 0 || second_connected_words.count == 0

    first_connected_words.each do |first_word|
      second_connected_words.each do |seconds_word|
        if @counted_topics.include?([first_word, seconds_word])
          return false
        end
      end
    end
    true
  end

  def _connected_duplicate_words(topic, included_index, unincluded_index)
    words = []
    @counted_topics.select { |t| t[included_index] == topic[included_index] }.each do |t|
      if _frequency(@counted_topics, unincluded_index)[t[unincluded_index]] > 1
        words << t[unincluded_index]
      end
    end
    words
  end


  # def _max_topics
  #   remaining_first_freq = _frequency(@topics, 0).count
  #   remaining_second_freq = _frequency(@topics, 1).count
  #   [remaining_first_freq, remaining_second_freq].max
  # end

  # def _remove_uniques
  #   @topics.reject! do |topic|
  #     @first_word_freq[topic[0]] == 1 || @second_word_freq[topic[1]] == 1
  #   end
  # end

  # def _populate_topic_frequency
  #   @first_word_freq = _frequency(@topics, 0)
  #   @second_word_freq = _frequency(@topics, 1)
  # end

  def _frequency(topics, index)
    topics.reduce({}) do |hash, pair|
      topic = pair[index]
      hash[topic] ||= 0
      hash[topic] += 1
      hash
    end
  end
end
