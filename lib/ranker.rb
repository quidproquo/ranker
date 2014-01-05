require 'ranker/ranking'
require 'ranker/rankings'
require 'ranker/strategies'
require 'ranker/version'

##
# Ranks are based on: http://en.wikipedia.org/wiki/Ranking
#
module Ranker

  class << self

    # Properties:

    def strategies
      @strategies ||= {
        :standard_competition => Ranker::Strategies::StandardCompetition,
        :modified_competition => Ranker::Strategies::ModifiedCompetition,
        :dense => Ranker::Strategies::Dense,
        :ordinal => Ranker::Strategies::Ordinal
      }
    end

    # Methods:

    def rank(values, *options)
      if options && options.kind_of?(Hash)
        options = default_options.merge(options)
      else
        options = default_options.merge({})
      end
      strategy = get_strategy(values, options)
      strategy.rank
    end


    protected

    # Properties:

    def default_options
      {
        :strategy => :standard_competition,
        :score => lambda { |scorable| scorable },
        :asc => true
      }
    end

    # Methods:

    def get_strategy(values, options)
      strategy_class = get_strategy_class(options[:strategy])
      strategy_class.new(values, options)
    end

    def get_strategy_class(strategy)
      if strategy.kind_of?(Class)
        strategy
      else
        if strategy = strategies[strategy]
          strategy
        else
          raise ArgumentError.new("Unknown strategy: #{strategy}")
        end
      end
    end

  end # class methods

end

