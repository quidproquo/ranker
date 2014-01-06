module Ranker::Strategies

  class Strategy

    attr_reader :values, :options

    def initialize(values, *args)
      @values = values
      options = args.pop
      if options && options.kind_of?(Hash)
        @options = default_options.merge(options)
      else
        @options = default_options
      end
    end


    # Properties:

    def rankings
      @rankings ||= Ranker::Rankings.new(self)
    end


    # Methods:


    def rank
      execute
      rankings
    end


    protected

    # Properties:

    def default_options
      {
        :by => lambda { |scorable| scorable },
        :desc => true
      }
    end

    def score
      options[:by]
    end

    def sort_desc?
      options[:desc]
    end

    def values_grouped_by_score
      @values_grouped_by_score ||= values.group_by(&score)
    end

    def scores_unique_sorted
      @scores_unique_sorted ||= unless sort_desc?
        values_grouped_by_score.keys.sort!
      else
        values_grouped_by_score.keys.sort!.reverse!
      end
    end


    # Methods:

    def create_ranking(rank, score, values)
      rankings.create(rank, score, values)
    end

    def execute
      raise NotImplementedError.new('You must implement the execute method.')
    end

    def values_for_score(score)
      values_grouped_by_score[score]
    end

  end # class

end # module
