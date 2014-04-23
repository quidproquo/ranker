require 'spec_helper'

describe Ranker::Rankings do
  let(:klass) { Ranker::Rankings }
  let(:strategy) { double(:strategy) }
  let(:rankings) { klass.new(strategy) }

  describe :properties do

    describe :mean do
      let(:rankables) { raise NotImplementedError }
      subject { rankings.mean }
      before {
        rankables.each_with_index { |value, index|
          rankings.create_ranking(index + 1, value, [value])
        }
      }

      context 'when there are rankables' do
        let(:rankables) { [1, 2, 3, 4, 5, 5, 1, 2] }
        it { should == 2.875 }
      end

      context 'when there are no rankables' do
        let(:rankables) { [] }
        it { should be_nan }
      end

      context 'when rankables contain nil values' do
        let(:rankables) { [1, 2, 3, nil, 5, 6, 7] }
        it 'should raise an error' do
          lambda { rankings.mean }.should raise_error(Ranker::Rankings::Error)
        end
      end

    end # mean

    describe :standard_deviation do
      let(:rankables) { raise NotImplementedError }
      subject { rankings.standard_deviation }
      before {
        rankables.each_with_index { |value, index|
          rankings.create_ranking(index + 1, value, [value])
        }
      }

      context 'when there are rankables' do
        let(:rankables) { [1, 2, 3, 4, 5, 5, 1, 2] }
        it { should == 1.5360257159305635 }
      end

      context 'when all rankables are the same' do
        let(:rankables) { [1, 1, 1, 1, 1, 1, 1] }
        it { should == 0 }
      end

      context 'when there are no rankables' do
        let(:rankables) { [] }
        it { should be_nan }
      end

      context 'when rankables contain nil values' do
        let(:rankables) { [1, 2, 3, nil, 5, 6, 7] }
        it 'should raise an error' do
          lambda { rankings.standard_deviation }.should raise_error(Ranker::Rankings::Error)
        end
      end

    end # standard_deviation

    describe :valid? do
      let(:rankables) { raise NotImplementedError }
      let(:valid) { rankings.valid? }
      subject { valid }
      before {
        rankables.each_with_index { |value, index|
          rankings.create_ranking(index + 1, value, [value])
        }
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
          subject { rankings.errors['scores'] }
          it { should == 'contains nil values' }
        end
      end

    end # valid?

  end # properties

end
