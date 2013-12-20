require 'spec_helper'

describe Ranker::StandardCompetitionRankingStrategy do
  let(:strategy) { Ranker::StandardCompetitionRankingStrategy.new }

  describe :methods do

    describe :rank do
      let(:values) { [1, 1, 2, 3, 3, 4, 5, 6, 7, 7, 7, 1, 1, 3] }
      let(:rankings) { strategy.rank(values) }
      subject { rankings }
      it { should have(7).items }

      context '1st ranking' do
        let(:ranking) { rankings[0] }
        subject { ranking }
        its(:rank) { should == 1 }
        its(:values) { should == [7, 7, 7] }
      end

      context '2nd ranking' do
        let(:ranking) { rankings[1] }
        subject { ranking }
        its(:rank) { should == 4 }
        its(:values) { should == [6] }
      end

      context '3rd ranking' do
        let(:ranking) { rankings[2] }
        subject { ranking }
        its(:rank) { should == 5 }
        its(:values) { should == [5] }
      end

      context '4th ranking' do
        let(:ranking) { rankings[3] }
        subject { ranking }
        its(:rank) { should == 6 }
        its(:values) { should == [4] }
      end

      context '5th ranking' do
        let(:ranking) { rankings[4] }
        subject { ranking }
        its(:rank) { should == 7 }
        its(:values) { should == [3, 3, 3] }
      end

      context '6th ranking' do
        let(:ranking) { rankings[5] }
        subject { ranking }
        its(:rank) { should == 10 }
        its(:values) { should == [2] }
      end

      context '7th ranking' do
        let(:ranking) { rankings[6] }
        subject { ranking }
        its(:rank) { should == 11 }
        its(:values) { should == [1, 1, 1, 1] }
      end

    end # rank

  end # methods

end
