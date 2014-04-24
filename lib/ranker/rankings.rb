module Ranker

  class Rankings < Array

    attr_reader :strategy, :scores

    def initialize(strategy)
      @strategy = strategy
      @scores = []
    end


    # Properties:

    def errors
      @errors ||= {}
    end

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
      raise Error.new(errors) unless valid?

      @total ||= scores.reduce(:+)
    end

    def total_difference
      @total_difference ||= scores.reduce(0) { |sum, score|
        sum + (score - mean) ** 2
      }
    end

    def valid?
      validate
      errors.empty?
    end


    # Methods:

    def create_ranking(rank, score, rankables)
      scores.concat(Array.new(rankables.count, score))
      ranking = Ranking.new(self, self.count, rank, score, rankables)
      self << ranking
      ranking
    end


    protected

    def validate
      errors.clear
      validate_scores
    end

    def validate_scores
      if scores_have_nil_values?
        errors['scores'] = 'contains nil values'
      end
    end

    def scores_have_nil_values?
      scores.any? { |score|
        score == nil
      }
    end


    # Inner classes:

    class Error < Ranker::Error

      def initialize(errors)
        message = 'Rankings has errors: '
        message << errors.map { |name, error|
          "#{name} #{error}"
        }.join(', ')
        super(message)
      end

    end # Error class

  end # Rankings class

end # Ranker module
