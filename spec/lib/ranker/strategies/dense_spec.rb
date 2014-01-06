require 'spec_helper'

describe Ranker::Strategies::Dense do
  let(:klass) { Ranker::Strategies::Dense }

  describe :methods do

    describe :rank do
      let(:rankables) { raise ArgumentError }
      let(:strategy) { klass.new(rankables) }
      let(:rankings) { strategy.rank }
      subject { rankings }

      context 'when list of rankables is large' do
        let(:rankables) { [1, 1, 2, 3, 3, 4, 5, 6, 7, 7, 7, 1, 1, 3] }
        it { should have(7).items }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking }
          its(:rank) { should == 1 }
          its(:rankables) { should == [7, 7, 7] }
        end

        context '2nd ranking' do
          let(:ranking) { rankings[1] }
          subject { ranking }
          its(:rank) { should == 2 }
          its(:rankables) { should == [6] }
        end

        context '3rd ranking' do
          let(:ranking) { rankings[2] }
          subject { ranking }
          its(:rank) { should == 3 }
          its(:rankables) { should == [5] }
        end

        context '4th ranking' do
          let(:ranking) { rankings[3] }
          subject { ranking }
          its(:rank) { should == 4 }
          its(:rankables) { should == [4] }
        end

        context '5th ranking' do
          let(:ranking) { rankings[4] }
          subject { ranking }
          its(:rank) { should == 5 }
          its(:rankables) { should == [3, 3, 3] }
        end

        context '6th ranking' do
          let(:ranking) { rankings[5] }
          subject { ranking }
          its(:rank) { should == 6 }
          its(:rankables) { should == [2] }
        end

        context '7th ranking' do
          let(:ranking) { rankings[6] }
          subject { ranking }
          its(:rank) { should == 7 }
          its(:rankables) { should == [1, 1, 1, 1] }
        end

      end # when list of rankables is large

      context 'when list of rankables is small' do
        let(:rankables) { [3, 2, 2, 1] }
        it { should have(3).items }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking }
          its(:rank) { should == 1 }
          its(:rankables) { should == [3] }
        end

        context '2nd ranking' do
          let(:ranking) { rankings[1] }
          subject { ranking }
          its(:rank) { should == 2 }
          its(:rankables) { should == [2, 2] }
        end

        context '3rd ranking' do
          let(:ranking) { rankings[2] }
          subject { ranking }
          its(:rank) { should == 3 }
          its(:rankables) { should == [1] }
        end

      end # list of rankables is small

    end # rank

  end # methods

end
