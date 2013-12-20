module Ranker::Strategies

  ##
  # Ranks values according to: http://en.wikipedia.org/wiki/Ranking#Standard_competition_ranking_.28.221224.22_ranking.29
  #
  class StandardCompetition < Strategy

    # Methods:

    def rank(values, &block)
      unless block_given?
        block = lambda { |value| value }
      end
      values_map = values.group_by(&block)
      values_sorted = values_map.keys.sort!.reverse!
      rankings = Ranker::Rankings.new
      current_rank = 1
      values_sorted.each_with_index { |value, index|
        rank = current_rank
        values_for_ranking = values_map[value]
        ranking = Ranker::Ranking.new(rank, values_for_ranking)
        rankings << ranking
        current_rank += values_for_ranking.count
      }
      rankings
    end

  end # class

end # module
