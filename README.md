Ranker [![Build Status](https://travis-ci.org/quidproquo/ranker.png?branch=master)](http://travis-ci.org/quidproquo/ranker)
======

A Ruby library for ranking scorable types using various ranking strategies.

Compatibility
-------------

Ranker is tested against MRI (1.8.7+).

Installation
------------

With bundler, add the `ranker` gem to your `Gemfile`.

```ruby
gem "ranker", "~> 1.0"
```

Require the `ranker` gem in your application.

```ruby
require "ranker"
```

Usage
-----

### Default Ranking

Default ranking will assume values are numeric and rank them in descending order.

```ruby
scores = [1, 1, 2, 3, 3, 1, 4, 4, 5, 6, 8, 1, 0]
rankings = Ranker.rank(values)
rankings.count #=> 8
ranking_1 = rankings[0]
ranking_1.rank #=> 1
ranking_1.score #=> 8
```

### Custom Ranking

Custom ranking allows for ranking arbitrary types using a lambda.

```ruby
class Player
  attr_accesor :score
  
  def initalize(score)
    @score = score
  end
end

players = [Player.new(0), Player.new(100), Player.new(1000), Player.new(25)]
score = lambda { |player| player.score }
rankings = Ranker.rank(players, :score => score)
```

