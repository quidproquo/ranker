require 'ranker/ranking'
require 'ranker/rankings'
require 'ranker/strategies'
require 'ranker/version'

##
# Ranks are based on: http://en.wikipedia.org/wiki/Ranking
#
module Ranker

  class << self

    def rank(values, *options)
      if options && options.kind_of(Hash)
        options = default_options.merge(options)
      else
        options = default_options
      end
      strategy = get_strategy(values, options.except(:strategy))
      strategy.rank
    end


    protected

    # Properties:

    def default_options
      {
        strategy: :standard_competition,
        scorer: lambda { |score| score },
        asc: true
      }
    end

    # Methods:

    def get_strategy(values, options)
      strategy_class = get_strategy_class(options[:strategy])
      strategy_class.new(valuew, options)
    end

    def get_strategy_class(strategy)
      unless strategy.kind_of(Class)
        "Ranker::Strategies::#{strategy.to_s.camelcase}".constantize
      else
        strategy
      end
    end

  end # class methods

end

