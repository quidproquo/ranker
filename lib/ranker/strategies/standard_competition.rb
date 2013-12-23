module Ranker::Strategies

  ##
  # Ranks values according to: http://en.wikipedia.org/wiki/Ranking#Standard_competition_ranking_.28.221224.22_ranking.29
  #
  class StandardCompetition < Strategy

    # Methods:

    def rank
      rank = 1
      scores_unique_sorted.each_with_index { |score, index|
        values_for_score = values_for_score(score)
        create_ranking(rank, score, values_for_score)
        rank += values_for_score.count
      }
      rankings
    end

  end # class

end # module
