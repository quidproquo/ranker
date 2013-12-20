module Ranker

  class RankingStrategy

    # Methods:

    def rank(values)
      raise NotImplementedError.new('You must implement rank.')
    end

  end # class

end # module
