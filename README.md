Ranker [![Build Status](https://travis-ci.org/quidproquo/ranker.png?branch=master)](http://travis-ci.org/quidproquo/ranker) [![Code Climate](https://codeclimate.com/github/quidproquo/ranker.png)](https://codeclimate.com/github/quidproquo/ranker) [![Coverage Status](https://coveralls.io/repos/quidproquo/ranker/badge.png?branch=master)](https://coveralls.io/r/quidproquo/ranker?branch=master)
======

A Ruby library for ranking scorable types using various ranking strategies.

Compatibility
-------------

Ranker is tested against MRI (1.8.7+) and JRuby (1.9.0+).

Installation
------------

With bundler, add the `ranker` gem to your `Gemfile`.

```ruby
gem "ranker"
```

Require the `ranker` gem in your application.

```ruby
require "ranker"
```

Usage
-----

### Default Ranking

Default ranking will assume values are numeric and rank them in their natural sorting (ascending) order. For example, a score of 100 is higher than a score of 50.

```ruby
scores = [1, 1, 2, 3, 3, 1, 4, 4, 5, 6, 8, 1, 0, 8]

rankings = Ranker.rank(scores)
rankings.count #=> 8

ranking = rankings[0]
ranking.rank #=> 1
ranking.score #=> 8
ranking.rankables #=> [8, 8]
ranking.percentile #=> 100
ranking.z_score #=> 1.83921346366645
```

### Custom Ranking

Custom ranking allows for ranking of objects by using a symbol or a lambda.

```ruby
class Player
  attr_accesor :score
  
  def initalize(score)
    @score = score
  end
end

players = [Player.new(0), Player.new(100), Player.new(1000), Player.new(25)]
rankings = Ranker.rank(players, :by => lambda { |player| player.score })
# or
rankings = Ranker.rank(players, :by => :score)
```

In some cases objects need to be ranked by score in descending order, for example, if you were ranking golf players. In this case a score of 75 is higher than a score of 100.


```ruby
class GolfPlayer < Player
end

players = [GolfPlayer.new(72), GolfPlayer.new(100), GolfPlayer.new(138), GolfPlayer.new(54)]
rankings = Ranker.rank(players, :by => :score, :asc => false)
```

### Ranking Strategies

Ranker has a number of ranking strategies available to use, mostly based on the Wikipedia entry on [ranking](http://en.wikipedia.org/wiki/Ranking). Strategies can be passed in as an option to the rank method.

```ruby
rankings = Ranker.rank(players, :by => :score, :strategy => :ordinal)
```

#### Standard Competition Ranking ("1224" ranking)

This is the default ranking strategy. For more info, see the Wikipedia entry on [Standard Competition Ranking](http://en.wikipedia.org/wiki/Ranking#Standard_competition_ranking_.28.221224.22_ranking.29).

```ruby
rankings = Ranker.rank(players, :by => :score, :strategy => :standard_competition)
```

#### Modified Competition Ranking ("1334" ranking)

For more info, see the Wikipedia entry on [Modified Competition Ranking](http://en.wikipedia.org/wiki/Ranking#Modified_competition_ranking_.28.221334.22_ranking.29).

```ruby
rankings = Ranker.rank(players, :by => :score, :strategy => :modified_competition)
```

#### Dense Ranking ("1223" ranking)

For more info, see the Wikipedia entry on [Dense Ranking](http://en.wikipedia.org/wiki/Ranking#Dense_ranking_.28.221223.22_ranking.29).

```ruby
rankings = Ranker.rank(players, :by => :score, :strategy => :dense)
```

#### Ordinal Ranking ("1234" ranking)

For more info, see the Wikipedia entry on [Ordinal Ranking](http://en.wikipedia.org/wiki/Ranking#Ordinal_ranking_.28.221234.22_ranking.29).

```ruby
rankings = Ranker.rank(players, :by => :score, :strategy => :ordinal)
```

#### Custom Ranking

If you find the current strategies not to your liking, you can write your own and pass the class into the rank method.

```ruby
class MyCustomStrategy < Ranker::Strategies::Strategy

  def execute
    # My code here
  end

end

rankings = Ranker.rank(players, :by => :score, :strategy => MyCustomStrategy)
```


Copyright
---------

Copyright &copy; 2013 Ilya Scharrenbroich. Released under the MIT License.



