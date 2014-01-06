module Ranker::Strategies

  ##
  # Ranks rankables according to: http://en.wikipedia.org/wiki/Ranking#Ordinal_ranking_.28.221234.22_ranking.29
  #
  class Ordinal < Strategy

    # Methods:

    def execute
      rank = 1
      scores_unique_sorted.each_with_index { |score, index|
        rankables_for_score = rankables_for_score(score)
        rankables_for_score.each { |value|
          create_ranking(rank, score, [value])
          rank += 1
        }
      }
    end

  end # class

end # module
