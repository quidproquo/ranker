module Ranker::Strategies

  ##
  # Ranks values according to: http://en.wikipedia.org/wiki/Ranking#Dense_ranking_.28.221223.22_ranking.29
  #
  class Dense < Strategy

    # Methods:

    def execute
      scores_unique_sorted.each_with_index { |score, index|
        rank = index + 1
        values_for_score = values_for_score(score)
        create_ranking(rank, score, values_for_score)
      }
    end

  end # class

end # module
