module Ranker

  class Ranking

    attr_reader :rankings, :index, :rank, :score, :values

    def initialize(rankings, index, rank, score, values)
      @rankings = rankings
      @index = index
      @rank = rank
      @score = score
      @values = values
    end

    # Properties:

    def percenitle

    end

    def z_score

    end

  end # class

end # module

