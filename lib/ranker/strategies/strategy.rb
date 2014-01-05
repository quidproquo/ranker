module Ranker::Strategies

  class Strategy

    attr_reader :values, :options

    def initialize(values, *args)
      @values = values
      options = args.pop
      if options && options.kind_of?(Hash)
        @options = default_options.merge(options)
      else
        @options = default_options.merge({})
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
        :score => lambda { |scorable| scorable },
        :asc => true
      }
    end

    def score
      options[:score]
    end

    def sort_asc?
      options[:asc]
    end

    def values_grouped_by_score
      @values_grouped_by_score ||= values.group_by(&score)
    end

    def scores_unique_sorted
      @scores_unique_sorted ||= if sort_asc?
        values_grouped_by_score.keys.sort!.reverse!
      else
        values_grouped_by_score.keys.sort!
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
