require 'spec_helper'

describe Ranker do
  let(:klass) { Ranker }

  describe :class_methods do

    describe :rank do
      let(:rankables) { raise NotImplementedError }
      let(:rankings) { klass.rank(rankables) }
      subject { rankings }

      context 'when simple rankables are used' do
        let(:rankables) { [1, 1, 2, 3, 3, 4, 5, 6, 7, 7, 7, 1, 1, 3] }
        subject { rankings }
        it { should have(7).items }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking }
          its(:rank) { should == 1 }
          its(:rankables) { should == [7, 7, 7] }
        end

        context 'last ranking' do
          let(:ranking) { rankings[-1] }
          subject { ranking }
          its(:rank) { should == 11 }
          its(:rankables) { should == [1, 1, 1, 1] }
        end

      end # when simple rankables are used

      context 'when ranking by symbol' do
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
          its(:rankables) { should =~ [player_1] }
        end

        context '2nd ranking' do
          let(:ranking) { rankings[1] }
          subject { ranking }
          its(:rank) { should == 2 }
          its(:rankables) { should =~ [player_2, player_3] }
        end

        context '3rd ranking' do
          let(:ranking) { rankings[2] }
          subject { ranking }
          its(:rank) { should == 4 }
          its(:rankables) { should =~ [player_4] }
        end

      end # when ranking by symbol

      context 'when ranking by symbol and asc false' do
        let(:player_1) { Player.new(150) }
        let(:player_2) { Player.new(100) }
        let(:player_3) { Player.new(100) }
        let(:player_4) { Player.new(25) }
        let(:players) { [player_1, player_2, player_3, player_4] }
        let(:rankings) { klass.rank(players, :by => :score, :asc => false) }
        it { should have(3).items }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking }
          its(:rank) { should == 1 }
          its(:rankables) { should =~ [player_4] }
        end

        context '2nd ranking' do
          let(:ranking) { rankings[1] }
          subject { ranking }
          its(:rank) { should == 2 }
          its(:rankables) { should =~ [player_2, player_3] }
        end

        context '3rd ranking' do
          let(:ranking) { rankings[2] }
          subject { ranking }
          its(:rank) { should == 4 }
          its(:rankables) { should =~ [player_1] }
        end

      end # when ranking by symbol

      context 'when using lambda to rank by' do
        let(:player_1) { Player.new(150) }
        let(:player_2) { Player.new(100) }
        let(:player_3) { Player.new(100) }
        let(:player_4) { Player.new(25) }
        let(:players) { [player_1, player_2, player_3, player_4] }
        let(:rankings) { klass.rank(players, :by => lambda { |player| player.score}) }
        it { should have(3).items }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking }
          its(:rank) { should == 1 }
          its(:rankables) { should =~ [player_1] }
        end

        context '2nd ranking' do
          let(:ranking) { rankings[1] }
          subject { ranking }
          its(:rank) { should == 2 }
          its(:rankables) { should =~ [player_2, player_3] }
        end

        context '3rd ranking' do
          let(:ranking) { rankings[2] }
          subject { ranking }
          its(:rank) { should == 4 }
          its(:rankables) { should =~ [player_4] }
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
