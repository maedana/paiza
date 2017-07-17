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
    subject do
      highlight = Highlight.new(input)
      # xxxoooxxxoooxxxooo
      highlight.actives = [[4, 6], [10, 12], [16, 18]]
      highlight.highlight(s, e)
      highlight.actives
    end

    let(:input) do
      <<~EOS
        10 3
        2 6
        6 8
        3 4
      EOS
    end

    context '最初に追加されるパターン' do
      let(:s) { 1 }
      let(:e) { 2 }

      it { is_expected.to eq [[1, 2], [4, 6], [10, 12], [16, 18]] }
    end

    context '最初に繋がるパターン1' do
      let(:s) { 1 }
      let(:e) { 3 }

      it { is_expected.to eq [[1, 6], [10, 12], [16, 18]] }
    end

    context '最初に繋がるパターン2' do
      let(:s) { 1 }
      let(:e) { 4 }

      it { is_expected.to eq [[1, 6], [10, 12], [16, 18]] }
    end

    context '最初に繋がるパターン3' do
      let(:s) { 1 }
      let(:e) { 6 }

      it { is_expected.to eq [[1, 6], [10, 12], [16, 18]] }
    end

    context '最初に繋がるパターン4' do
      let(:s) { 1 }
      let(:e) { 7 }

      it { is_expected.to eq [[1, 7], [10, 12], [16, 18]] }
    end

    context '最初に繋がるパターン5' do
      let(:s) { 1 }
      let(:e) { 9 }

      it { is_expected.to eq [[1, 9], [10, 12], [16, 18]] }
    end

    context '最初に繋がるパターン6' do
      let(:s) { 1 }
      let(:e) { 12 }

      it { is_expected.to eq [[1, 12], [16, 18]] }
    end

    context '最後に繋がるパターン1' do
      let(:s) { 6 }
      let(:e) { 7 }

      # it { is_expected.to eq [[4, 6], [10, 12], [16, 18]] }
      it { is_expected.to eq [[4, 7], [10, 12], [16, 18]] }
    end

    context '最後に繋がるパターン2' do
      let(:s) { 7 }
      let(:e) { 7 }

      # it { is_expected.to eq [[4, 6], [10, 12], [16, 18]] }
      it { is_expected.to eq [[4, 7], [10, 12], [16, 18]] }
    end

    context '最後に繋がるパターン3' do
      let(:s) { 7 }
      let(:e) { 8 }

      # it { is_expected.to eq [[4, 6], [10, 12], [16, 18]] }
      it { is_expected.to eq [[4, 8], [10, 12], [16, 18]] }
    end

    context '最後に繋がるパターン4' do
      let(:s) { 7 }
      let(:e) { 9 }

      # it { is_expected.to eq [[4, 6], [10, 12], [16, 18]] }
      it { is_expected.to eq [[4, 12], [16, 18]] }
    end

    context '最後に追加されるパターン1' do
      let(:s) { 20 }
      let(:e) { 22 }

      it { is_expected.to eq [[4, 6], [10, 12], [16, 18], [20, 22]] }
    end

    context '最後に追加されるパターン2' do
      let(:s) { 18 }
      let(:e) { 22 }

      it { is_expected.to eq [[4, 6], [10, 12], [16, 22]] }
    end

    context '最後に追加されるパターン3' do
      let(:s) { 19 }
      let(:e) { 22 }

      it { is_expected.to eq [[4, 6], [10, 12], [16, 22]] }
    end
  end

  describe '#highlightその2' do
    subject do
      highlight = Highlight.new(input)
      highlight.actives = actives
      highlight.highlight(s, e)
      highlight.actives
    end

    let(:input) do
      <<~EOS
        10 3
        2 6
        6 8
        3 4
      EOS
    end

    context 'パターン1' do
      let(:actives) { [[14, 14], [53, 59], [65, 77], [83, 100]] }
      let(:s) { 43 }
      let(:e) { 45 }

      it { is_expected.to eq [[14, 14], [43, 45], [53, 59], [65, 77], [83, 100]] }
    end

    context 'パターン2' do
      let(:actives) { [[6, 7], [14, 14], [43, 45], [53, 59], [65, 77], [83, 100]] }
      let(:s) { 44 }
      let(:e) { 45 }

      it { is_expected.to eq [[6, 7], [14, 14], [43, 43], [53, 59], [65, 77], [83, 100]] }
    end

    context 'パターン3' do
      let(:actives) { [[1, 1], [6, 6]] }
      let(:s) { 1 }
      let(:e) { 7 }

      it { is_expected.to eq [[1, 7]] }
    end
  end

  describe '#unhilight' do
    subject do
      highlight = Highlight.new(input)
      highlight.actives = actives
      highlight.unhilight(s, e)
      highlight.actives
    end

    let(:input) do
      <<~EOS
        10 3
        2 6
        6 8
        3 4
      EOS
    end

    context 'パターン1' do
      let(:actives) { [[43, 45]] }
      let(:s) { 44 }
      let(:e) { 45 }

      it { is_expected.to eq [[43, 43]] }
    end
  end
end

# 実行時間に注意がいるな
# ・1 ≦ L ≦ 1,000,000,000 => 10**9
# ・0 ≦ N ≦ 100,000 => 10**6
# ・1 ≦ a_i ≦ b_i ≦ L (1 ≦ i ≦ N)
