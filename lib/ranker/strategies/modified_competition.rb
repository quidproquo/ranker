module Ranker::Strategies

  ##
  # Ranks values according to: http://en.wikipedia.org/wiki/Ranking#Modified_competition_ranking_.28.221334.22_ranking.29
  #
  class ModifiedCompetition < Strategy

    # Methods:

    def rank(values)
      values_map = values.group_by { |value|
        value
      }
      values_sorted = values_map.keys.sort!.reverse!
      rankings = Ranker::Rankings.new
      current_rank = 0
      values_sorted.each_with_index { |value, index|
        values_for_ranking = values_map[value]
        if current_rank == 0
          rank = 1
          current_rank += values_for_ranking.count
        else
          current_rank += values_for_ranking.count
          rank = current_rank
        end
        ranking = Ranker::Ranking.new(rank, values_for_ranking)
        rankings << ranking
      }
      rankings
    end

  end # class

end # module
