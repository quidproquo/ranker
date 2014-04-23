require 'spec_helper'

describe Ranker::Strategies::StandardCompetition do
  let(:klass) { Ranker::Strategies::Strategy }

  describe :initialize do
    let(:rankables) { [1, 2, 3, 4, 5, 5, 6, 7, 7, 7, 2] }
    let(:strategy) { klass.new(rankables) }
    subject { strategy }
    its(:rankables) { should == rankables }
    its(:rankings) { should be }
    its(:options) { should be }
    its(:score) { should be }
  end

  describe :properties do

    describe :valid? do
      let(:rankables) { raise NotImplementedError }
      let(:strategy) { klass.new(rankables) }
      let(:valid) { strategy.valid? }
      subject { valid }
      before {
        valid
      }

      context 'when rankables are not nil' do
        let(:rankables) { [1, 2, 3, 4, 5, 6, 7] }
        it { should == true }
      end

      context 'when rankables contain nil values' do
        let(:rankables) { [1, 2, 3, nil, 5, 6, 7] }
        it { should == false }

        context 'errors' do
          subject { strategy.errors['scores'] }
          it { should == 'contains nil values' }
        end
      end

    end # valid?

  end # properties

  describe :methods do

    describe :rank do
      let(:strategy) { klass.new([]) }
      subject { strategy }
      it 'should be an abstract method' do
        lambda { strategy.rank }.should raise_error(NotImplementedError)
      end

      context 'when rankables has nil values' do
        let(:rankables) { [1, 2, 3, nil, 5, 6, 7] }
        let(:strategy) { klass.new(rankables) }
        it 'should raise an error' do
          lambda { strategy.rank }.should raise_error(Ranker::Strategies::Strategy::Error)
        end
      end # when rankables had nil values

    end # rank

  end # methods

end
