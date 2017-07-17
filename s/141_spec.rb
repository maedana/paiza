require 'rspec'
require File.join(File.dirname(__FILE__), '141.rb')

describe 'S012' do
  subject { f(input) }

  describe '入力例1' do
    let(:input) do
      <<~EOS
        10 3
        2 6
        6 8
        3 4
      EOS
    end
    it { is_expected.to eq '5' }
  end

  describe '入力例2' do
    let(:input) do
      <<~EOS
        10 10
        1 6
        2 5
        1 7
        1 7
        2 7
        2 8
        1 4
        2 2
        1 10
        2 10
      EOS
    end
    it { is_expected.to eq '1' }
  end

  describe '入力例3' do
    let(:input) do
      <<~EOS
        100 5
        1 100
        1 100
        1 100
        1 100
        1 100
      EOS
    end
    it { is_expected.to eq '100' }
  end

  describe '入力例4' do
    let(:input) do
      <<~EOS
        100 20
        14 14
        53 100
        60 64
        78 82
        43 45
        6 7
        44 45
        83 98
        55 58
        34 34
        21 37
        17 73
        90 98
        55 62
        69 76
        25 73
        11 89
        92 94
        49 53
        17 17
      EOS
    end
    it { is_expected.to eq '83' }
  end
end

describe Highlight do
  describe '#inialize' do
    subject(:highlight) do
      Highlight.new(input)
    end

    let(:input) do
      <<~EOS
        10 3
        2 6
        6 8
        3 4
      EOS
    end

    it { expect(highlight.l).to eq 10 }
    it { expect(highlight.n).to eq 3 }
    it { expect(highlight.logs).to eq [[2, 6], [6, 8], [3, 4]] }
  end

  describe '#highlight' do
    subject(:highlight) do
      Highlight.new(input)
    end

    let(:input) do
      <<~EOS
        10 3
        2 6
        6 8
        3 4
      EOS
    end

    context '1回目' do
      subject do
        super().highlight(2, 6)
        super().actives
      end

      let(:expected) do
        [
          [2, 6]
        ]
      end

      it { is_expected.to eq expected }
    end

    context '2回目' do
      subject do
        super().highlight(2, 6)
        super().highlight(6, 8)
        super().actives
      end

      let(:expected) do
        [
          [2, 8]
        ]
      end

      it { is_expected.to eq expected }
    end

    context '3回目' do
      subject do
        super().highlight(2, 6)
        super().highlight(6, 8)
        super().highlight(3, 4)
        super().actives
      end

      let(:expected) do
        [
          [2, 3],
          [4, 8]
        ]
      end

      it { is_expected.to eq expected }
    end
  end
end

# 実行時間に注意がいるな
# ・1 ≦ L ≦ 1,000,000,000 => 10**9
# ・0 ≦ N ≦ 100,000 => 10**6
# ・1 ≦ a_i ≦ b_i ≦ L (1 ≦ i ≦ N)
