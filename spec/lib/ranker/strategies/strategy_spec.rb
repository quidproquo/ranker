require 'spec_helper'

describe Ranker::Strategies::StandardCompetition do
  let(:klass) { Ranker::Strategies::Strategy }

  describe :initialize do
    let(:values) { [1, 2, 3, 4, 5, 5, 6, 7, 7, 7, 2] }
    let(:strategy) { klass.new(values) }
    subject { strategy }
    its(:values) { should == values }
    its(:rankings) { should be }
    its(:options) { should be }
    its(:scorer) { should be }
  end

  describe :methods do

    describe :rank do
      let(:strategy) { klass.new([]) }
      subject { strategy }
      it 'should be an abstract method' do
        lambda { strategy.rank }.should raise_error(NotImplementedError)
      end
    end # rank

  end # methods

end