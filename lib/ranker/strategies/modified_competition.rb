module Ranker::Strategies

  ##
  # Ranks values according to: http://en.wikipedia.org/wiki/Ranking#Modified_competition_ranking_.28.221334.22_ranking.29
  #
  class ModifiedCompetition < Strategy

    # Methods:

    def execute
      rank = 0
      scores_unique_sorted.each_with_index { |score, index|
        values_for_score = values_for_score(score)
        if rank == 0
          create_ranking(1, score, values_for_score)
          rank += values_for_score.count
        else
          rank += values_for_score.count
          create_ranking(rank, score, values_for_score)
        end
      }
    end

  end # class

end # module
