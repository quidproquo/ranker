module Ranker::Strategies

  ##
  # Ranks rankables according to: http://en.wikipedia.org/wiki/Ranking#Standard_competition_ranking_.28.221224.22_ranking.29
  #
  class StandardCompetition < Strategy

    # Methods:

    def execute
      rank = 1
      scores_unique_sorted.each_with_index { |score, index|
        rankables_for_score = rankables_for_score(score)
        create_ranking(rank, score, rankables_for_score)
        rank += rankables_for_score.count
      }
    end

  end # class

end # module
