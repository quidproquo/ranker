module Ranker::Strategies

  class Strategy

    attr_reader :rankables, :options

    def initialize(rankables, *args)
      @rankables = rankables
      options = args.pop
      if options && options.kind_of?(Hash)
        @options = default_options.merge(options)
      else
        @options = default_options
      end
    end


    # Properties:

    def errors
      @errors ||= {}
    end

    def rankings
      @rankings ||= Ranker::Rankings.new(self)
    end

    def scores
      rankables_grouped_by_score.keys
    end

    def valid?
      validate
      errors.empty?
    end


    # Methods:


    def rank
      raise Error.new(errors) unless valid?

      execute
      rankings
    end


    protected

    # Properties:

    def default_options
      {
        :by => lambda { |rankable| rankable },
        :asc => true
      }
    end

    def score
      options[:by]
    end

    def sort_asc?
      options[:asc] == true
    end

    def rankables_grouped_by_score
      @rankables_grouped_by_score ||= rankables.group_by(&score)
    end

    def scores_unique_sorted
      @scores_unique_sorted ||= unless sort_asc?
        rankables_grouped_by_score.keys.sort!
      else
        rankables_grouped_by_score.keys.sort!.reverse!
      end
    end


    # Methods:

    def create_ranking(rank, score, rankables)
      rankings.create_ranking(rank, score, rankables)
    end

    def execute
      raise NotImplementedError.new('You must implement the execute method.')
    end

    def rankables_for_score(score)
      rankables_grouped_by_score[score]
    end

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
        message = 'Strategy has errors: '
        message << errors.map { |name, error|
          "#{name} #{error}"
        }.join(', ')
        super(message)
      end

    end # Error class

  end # Strategy class

end # Ranker::Strategies module
