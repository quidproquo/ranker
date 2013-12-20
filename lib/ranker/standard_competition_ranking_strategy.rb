module Ranker

  ##
  # Ranks values according to: http://en.wikipedia.org/wiki/Ranking#Standard_competition_ranking_.28.221224.22_ranking.29
  #
  class StandardCompetitionRankingStrategy < RankingStrategy

    # Methods:

    def rank(values)
      values_map = values.group_by { |value|
        value
      }
      values_sorted = values_map.keys.sort!.reverse!
      rankings = Rankings.new
      rankings_above = 1
      values_sorted.each_with_index { |value, index|
        rank = rankings_above
        values_for_ranking = values_map[value]
        ranking = Ranking.new(rank, values_for_ranking)
        rankings << ranking
        rankings_above += values_for_ranking.count
      }
      rankings
    end

  end # class

end # module
