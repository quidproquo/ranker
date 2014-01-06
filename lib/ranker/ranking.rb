module Ranker

  class Ranking

    attr_reader :rankings, :index, :rank, :score, :rankables

    def initialize(rankings, index, rank, score, rankables)
      @rankings = rankings
      @index = index
      @rank = rank
      @score = score
      @rankables = rankables
    end

    # Properties:

    def num_rankables
      rankables.count
    end

    def percentile
      @percentile ||= (num_scores_at_or_below.to_f / rankings.num_scores) * 100
    end

    def z_score
      @z_score ||= if rankings.standard_deviation == 0
        0
      else
        (score - rankings.mean) / rankings.standard_deviation
      end
    end

    protected

    def num_scores_at_or_below
      @scores_at_or_below ||= rankings[index..rankings.num_scores].reduce(0) { |sum, ranking|
        sum + ranking.num_rankables
      }
    end

  end # class

end # module

