module Ranker

  class Rankings < Array

    attr_reader :strategy, :scores

    def initialize(strategy)
      @strategy = strategy
      @scores = []
    end


    # Properties:

    def mean
      @mean ||= total.to_f / num_scores
    end

    def standard_deviation
      @standard_deviation ||= if variance.nan?
        # For ruby-1.8.7 compatibility
        variance
      else
        Math.sqrt(variance)
      end
    end

    def num_scores
      scores.size
    end

    def variance
      @variance ||= total_difference.to_f / num_scores
    end

    def total
      @total ||= scores.reduce(:+)
    end

    def total_difference
      @total_difference ||= scores.reduce(0) { |sum, score|
        sum + (score - mean) ** 2
      }
    end


    # Methods:

    def create(rank, score, values)
      scores.concat(Array.new(values.count, score))
      self << Ranking.new(self, self.count, rank, score, values)
    end

  end # class

end # module
