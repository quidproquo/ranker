require 'spec_helper'

describe Ranker do
  let(:klass) { Ranker }

  describe :class_methods do

    describe :rank do
      let(:values) { [1, 1, 2, 3, 3, 4, 5, 6, 7, 7, 7, 1, 1, 3] }
      let(:rankings) { klass.rank(values) }
      subject { rankings }
      it { should have(7).items }

      context '1st ranking' do
        let(:ranking) { rankings[0] }
        subject { ranking }
        its(:rank) { should == 1 }
        its(:values) { should == [7, 7, 7] }
      end

      context 'when using symbol to rank by' do
        let(:player_1) { Player.new(150) }
        let(:player_2) { Player.new(100) }
        let(:player_3) { Player.new(100) }
        let(:player_4) { Player.new(25) }
        let(:players) { [player_1, player_2, player_3, player_4] }
        let(:rankings) { klass.rank(players, :by => :score) }
        it { should have(3).items }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking }
          its(:rank) { should == 1 }
          its(:values) { should =~ [player_1] }
        end

        context '2nd ranking' do
          let(:ranking) { rankings[1] }
          subject { ranking }
          its(:rank) { should == 2 }
          its(:values) { should =~ [player_2, player_3] }
        end

        context '3rd ranking' do
          let(:ranking) { rankings[2] }
          subject { ranking }
          its(:rank) { should == 4 }
          its(:values) { should =~ [player_4] }
        end

      end # when ranking by symbol

    end # rank

  end # class_methods

end

class Player

  attr_reader :score

  def initialize(score)
    @score = score
  end

end
