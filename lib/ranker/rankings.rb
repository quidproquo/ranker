module Ranker

  class Rankings < Array

    attr_reader :strategy, :scores

    def initialize(strategy)
      @strategy = strategy
      @scores = []
    end


    # Properties:

    def mean
      @mean ||= (scores.sum / scores.count)
    end

    def standard_deviation
      @standard_deviation ||= Math.sqrt(variance)
    end

    def population_size
      scores.size
    end

    def variance
      (total_difference / population_size)
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
