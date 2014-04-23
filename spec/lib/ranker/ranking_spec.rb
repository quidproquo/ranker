require 'spec_helper'

describe Ranker::Ranking do
  let(:klass) { Ranker::Ranking }
  let(:strategy) { double(:strategy) }
  let(:rankings) { Ranker::Rankings.new(strategy) }

  describe :properties do

    describe :percentile do
      let(:rankables) { [1, 2, 3, 4, 5, 5, 1, 2] }
      before {
        rankables.each_with_index { |value, index|
          rankings.create_ranking(index + 1, value, [value])
        }
      }

      context '1st ranking' do
        let(:ranking) { rankings[0] }
        subject { ranking.percentile }
        it { should == 100 }
      end

      context '2nd ranking' do
        let(:ranking) { rankings[1] }
        subject { ranking.percentile }
        it { should == 87.5 }
      end

      context '3rd ranking' do
        let(:ranking) { rankings[2] }
        subject { ranking.percentile }
        it { should == 75.0 }
      end

      context 'last ranking' do
        let(:ranking) { rankings.last }
        subject { ranking.percentile }
        it { should == 12.5 }
      end

    end # percentile

    describe :z_score do
      let(:rankables) { [1, 2, 3, 4, 5, 5, 1, 2] }
      before {
        rankables.each_with_index { |value, index|
          rankings.create_ranking(index + 1, value, [value])
        }
      }

      context '1st ranking' do
        let(:ranking) { rankings[0] }
        subject { ranking.z_score }
        it { should == -1.2206826881567392 }
      end

      context '2nd ranking' do
        let(:ranking) { rankings[1] }
        subject { ranking.z_score }
        it { should == -0.5696519211398116 }
      end

      context '3rd ranking' do
        let(:ranking) { rankings[2] }
        subject { ranking.z_score }
        it { should == 0.08137884587711594 }
      end

      context 'last ranking' do
        let(:ranking) { rankings.last }
        subject { ranking.z_score }
        it { should == -0.5696519211398116 }
      end

      context 'when standard deviation is zero' do
        let(:rankables) { [1, 1, 1, 1, 1, 1, 1] }

        context '1st ranking' do
          let(:ranking) { rankings[0] }
          subject { ranking.z_score }
          it { should == 0 }
        end

      end # when standard deviation is zero

    end # z_score

  end # properties

end
