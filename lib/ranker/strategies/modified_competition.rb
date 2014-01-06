module Ranker::Strategies

  ##
  # Ranks rankables according to: http://en.wikipedia.org/wiki/Ranking#Modified_competition_ranking_.28.221334.22_ranking.29
  #
  class ModifiedCompetition < Strategy

    # Methods:

    def execute
      rank = 0
      scores_unique_sorted.each_with_index { |score, index|
        rankables_for_score = rankables_for_score(score)
        if rank == 0
          create_ranking(1, score, rankables_for_score)
          rank += rankables_for_score.count
        else
          rank += rankables_for_score.count
          create_ranking(rank, score, rankables_for_score)
        end
      }
    end

  end # class

end # module
