module Ranker

  class Ranking

    attr_reader :rankings, :index, :rank, :score, :values

    def initialize(rankings, index, rank, score, values)
      @rankings = rankings
      @index = index
      @rank = rank
      @score = score
      @values = values
    end

    # Properties:

    def num_values
      values.count
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
        sum + ranking.num_values
      }
    end

  end # class

end # module

