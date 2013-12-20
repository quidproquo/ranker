require 'ranker/ranking'
require 'ranker/rankings'
require 'ranker/version'

##
# Ranks are based on: http://en.wikipedia.org/wiki/Ranking
#
module Ranker

  class << self

    def rank(values)
      values_map = values.group_by { |value|
        value
      }
      values_sorted = values_map.keys.sort!.reverse!
      rankings = Rankings.new
      values_sorted.each_with_index { |value, index|
        rank = index + 1
        values_for_ranking = values_map[value]
        ranking = Ranking.new(rank, values_for_ranking)
        rankings << ranking
      }
      rankings
    end

  end # class methods

end

