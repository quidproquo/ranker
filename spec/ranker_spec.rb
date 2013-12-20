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

    end # rank

  end # class_methods

end
