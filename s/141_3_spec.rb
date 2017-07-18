require 'rspec'
require File.join(File.dirname(__FILE__), '141_3.rb')

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

  describe '入力例5' do
    let(:input) do
      <<~EOS
        1000000000 11
        1 1000000000
        1 1000000000
        1 1000000000
        1 1000000000
        1 1000000000
        1 1000000000
        1 1000000000
        1 1000000000
        1 1000000000
        1 1000000000
        1 1000000000
      EOS
    end
    it { is_expected.to eq '1000000000' }
  end

  describe '入力例6' do
    let(:input) do
      <<~EOS
        1000000000 0
      EOS
    end
    it { is_expected.to eq '0' }
  end

  describe '入力例7' do
    let(:input) do
      <<~EOS
        1 3
        1 1
        1 1
        1 1
      EOS
    end
    it { is_expected.to eq '1' }
  end
end

describe HilightLog do
  describe '#inialize' do
    subject(:log) do
      HilightLog.new(input)
    end

    let(:input) do
      <<~EOS
        10 3
        2 6
        6 8
        3 4
      EOS
    end

    it { expect(log.l).to eq 10 }
    it { expect(log.n).to eq 3 }
    it { expect(log.logs).to eq [[2, 6], [6, 8], [3, 4]] }
    it { expect(log.hilights.size).to eq 0 }
    it { expect(log.hilight_count).to eq 0 }
  end

  describe '#unhilight' do
    subject do
      log.hilights = hilights
      log.unhilight(s, e)
      log.hilights
    end

    let(:log) { HilightLog.new(input) }
    let(:input) { "9 0\n" }
    let(:hilights) { [(3..7)] }

    context '左側が重なる' do
      let(:s) { 2 }
      let(:e) { 3 }

      it { is_expected.to eq [(3..7)] }
    end

    context '右側が重なる' do
      let(:s) { 7 }
      let(:e) { 8 }

      it { is_expected.to eq [(3..7)] }
    end

    context '左右両方重なる' do
      let(:s) { 2 }
      let(:e) { 8 }

      it { is_expected.to eq [(3..7)] }
    end

    context '覆われている1' do
      let(:s) { 3 }
      let(:e) { 3 }

      it { is_expected.to eq [(4..7)] }
    end

    context '覆われている2' do
      let(:s) { 7 }
      let(:e) { 7 }

      it { is_expected.to eq [(3..6)] }
    end

    context '覆われている3' do
      let(:s) { 3 }
      let(:e) { 4 }

      it { is_expected.to eq [(5..7)] }
    end

    context '覆われている4' do
      let(:s) { 6 }
      let(:e) { 7 }

      it { is_expected.to eq [(3..5)] }
    end

    context '覆われている5' do
      let(:s) { 5 }
      let(:e) { 5 }

      it { is_expected.to eq [(3..4), (6..7)] }
    end

    context '覆われている6' do
      let(:s) { 3 }
      let(:e) { 7 }

      it { is_expected.to eq [] }
    end

    context '覆われている7' do
      let(:hilights) { [1..10, 12..12] }
      let(:s) { 2 }
      let(:e) { 10 }

      it { is_expected.to eq [1..1, 12..12] }
    end

    context '覆われている7' do
      let(:hilights) { [65..77, 83..100] }
      let(:s) { 83 }
      let(:e) { 98 }

      it { is_expected.to eq [65..77, 99..100] }
    end
  end

  describe '#hilight' do
    subject do
      log.hilights = hilights
      log.hilight(s, e)
      log.hilights
    end

    let(:log) { HilightLog.new(input) }
    let(:input) { "9 0\n" }
    let(:hilights) { [(3..7)] }

    context 'ハイライトなし' do
      let(:hilights) { [] }

      let(:s) { 2 }
      let(:e) { 2 }

      it { is_expected.to eq [(2..2)] }
    end

    context '左側に挿入' do
      let(:s) { 1 }
      let(:e) { 1 }

      it { is_expected.to eq [(1..1), (3..7)] }
    end

    context '左側が接する' do
      let(:s) { 2 }
      let(:e) { 2 }

      it { is_expected.to eq [(2..7)] }
    end

    context '左側が重なる' do
      let(:s) { 2 }
      let(:e) { 3 }

      it { is_expected.to eq [(2..7)] }
    end

    context '左側が重なる2' do
      let(:hilights) { [3..6, 9..10] }
      let(:s) { 1 }
      let(:e) { 5 }

      it { is_expected.to eq [1..6, 9..10] }
    end

    context '右側に挿入' do
      let(:s) { 9 }
      let(:e) { 9 }

      it { is_expected.to eq [(3..7), (9..9)] }
    end

    context '右側が重なる' do
      let(:s) { 7 }
      let(:e) { 8 }

      it { is_expected.to eq [(3..8)] }
    end

    context '右側が重なる2' do
      let(:hilights) { [3..6, 7..7, 13..16] }
      let(:s) { 4 }
      let(:e) { 9 }

      it { is_expected.to eq [3..9, 13..16] }
    end

    context '右側が接する' do
      let(:s) { 8 }
      let(:e) { 8 }

      it { is_expected.to eq [(3..8)] }
    end

    context '左右両方重なる' do
      let(:s) { 2 }
      let(:e) { 8 }

      it { is_expected.to eq [(2..8)] }
    end

    context '前後と接する' do
      let(:hilights) { [(3..4), (6..7)] }
      let(:s) { 5 }
      let(:e) { 5 }

      it { is_expected.to eq [(3..7)] }
    end

    context '覆われている1' do
      let(:s) { 3 }
      let(:e) { 3 }

      it { is_expected.to eq [(4..7)] }
    end

    context '覆われている2' do
      let(:s) { 7 }
      let(:e) { 7 }

      it { is_expected.to eq [(3..6)] }
    end

    context '覆われている3' do
      let(:s) { 3 }
      let(:e) { 4 }

      it { is_expected.to eq [(5..7)] }
    end

    context '覆われている4' do
      let(:s) { 6 }
      let(:e) { 7 }

      it { is_expected.to eq [(3..5)] }
    end

    context '覆われている5' do
      let(:s) { 5 }
      let(:e) { 5 }

      it { is_expected.to eq [(3..4), (6..7)] }
    end

    context '覆われている6' do
      let(:s) { 3 }
      let(:e) { 7 }

      it { is_expected.to eq [] }
    end

    context 'またぐ' do
      let(:hilights) { [(1..1), (6..6)] }
      let(:s) { 1 }
      let(:e) { 7 }

      it { is_expected.to eq [1..7] }
    end
  end
end

# 実行時間に注意がいるな
# ・1 ≦ L ≦ 1,000,000,000 => 10**9
# ・0 ≦ N ≦ 100,000 => 10**6
# ・1 ≦ a_i ≦ b_i ≦ L (1 ≦ i ≦ N)
