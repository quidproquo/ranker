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
      rankings.create(rank, score, rankables)
    end

    def execute
      raise NotImplementedError.new('You must implement the execute method.')
    end

    def rankables_for_score(score)
      rankables_grouped_by_score[score]
    end

  end # class

end # module
