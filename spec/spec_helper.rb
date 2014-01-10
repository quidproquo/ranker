require 'pry'
require File.expand_path('../../lib/ranker.rb',  __FILE__)


if RUBY_VERSION > "1.8.7"
  require 'coveralls'
  Coveralls.wear!
end

