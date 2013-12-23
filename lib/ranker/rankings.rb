module Ranker

  class Rankings < Array

    attr_reader :strategy

    def initialize(strategy)
      @strategy = strategy
    end


    # Properties:


    # Methods:

    def create(rank, score, values)
      self << Ranking.new(self, self.count, rank, score, values)
    end

  end # class

end # module
