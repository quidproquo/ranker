module Ranker::Strategies

  ##
  # Ranks values according to: http://en.wikipedia.org/wiki/Ranking#Dense_ranking_.28.221223.22_ranking.29
  #
  class Dense < Strategy

    # Methods:

    def rank(values)
      values_map = values.group_by { |value|
        value
      }
      values_sorted = values_map.keys.sort!.reverse!
      rankings = Ranker::Rankings.new
      values_sorted.each_with_index { |value, index|
        rank = index + 1
        values_for_ranking = values_map[value]
        ranking = Ranker::Ranking.new(rank, values_for_ranking)
        rankings << ranking
      }
      rankings
    end

  end # class

end # module
