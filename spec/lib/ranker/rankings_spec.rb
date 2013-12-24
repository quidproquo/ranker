require 'spec_helper'

describe Ranker::Rankings do
  let(:klass) { Ranker::Rankings }
  let(:strategy) { double(:strategy) }
  let(:rankings) { klass.new(strategy) }

  describe :properties do

    describe :mean do
      let(:values) { raise NotImplementedError }
      subject { rankings.mean }
      before {
        values.each_with_index { |value, index|
          rankings.create(index + 1, value, [value])
        }
      }

      context 'when there are values' do
        let(:values) { [1, 2, 3, 4, 5, 5, 1, 2] }
        it { should == 2.875 }
      end

      context 'when there are no values' do
        let(:values) { [] }
        it { should be_nan }
      end

    end # mean

    describe :standard_deviation do
      let(:values) { raise NotImplementedError }
      subject { rankings.standard_deviation }
      before {
        values.each_with_index { |value, index|
          rankings.create(index + 1, value, [value])
        }
      }

      context 'when there are values' do
        let(:values) { [1, 2, 3, 4, 5, 5, 1, 2] }
        it { should == 1.5360257159305635 }
      end

      context 'when all values are the same' do
        let(:values) { [1, 1, 1, 1, 1, 1, 1] }
        it { should == 0 }
      end

      context 'when there are no values' do
        let(:values) { [] }
        it { should be_nan }
      end

    end # standard_deviation

  end # properties

end
