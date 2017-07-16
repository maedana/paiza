require 'rspec'
require File.join(File.dirname(__FILE__), '102.rb')

describe 'S-102' do
  subject { f(n, s, m, p_text) }

  describe '入力例1' do
    let(:n) { '3' }
    let(:s) { '3 1 2' }
    let(:m) { '2' }
    let(:p_text) do
      <<~EOS
        1 3 2
        2 3 1
      EOS
    end

    it { is_expected.to eq '1 3 2' }
  end

  describe '入力例2' do
    let(:n) { '5' }
    let(:s) { '1 4 2 5 3' }
    let(:m) { '2' }
    let(:p_text) do
      <<~EOS
        5 2 1 4 3
        1 3 4 5 2
      EOS
    end

    it { is_expected.to eq '1 3 4 2 5' }
  end

  describe '入力例3' do
    let(:n) { '5' }
    let(:s) { '1 4 2 5 3' }
    let(:m) { '5' }
    let(:p_text) do
      <<~EOS
        1 2 3 4 5
        2 1 3 4 5
        2 3 1 4 5
        5 2 1 4 3
        1 3 4 5 2
      EOS
    end

    it { is_expected.to eq '1 2 4 3 5' }
  end
end

describe Progression do
  describe '#prepare_p' do
    subject do
      progression = Progression.new(n, s, m, p_text)
      progression.p
    end

    let(:n) { '3' }
    let(:s) { '3 1 2' }
    let(:m) { '2' }
    let(:p_text) do
      <<~EOS
        1 3 2
        2 3 1
      EOS
    end

    it { is_expected.to eq [[1, 3, 2], [2, 3, 1]] }
  end

  describe '#apply' do
    subject do
      progression = Progression.new(n, s, m, p_text)
      progression.apply(p_array)
    end

    let(:n) { '3' }
    let(:s) { '3 1 2' }
    let(:m) { '2' }
    let(:p_text) do
      <<~EOS
        1 3 2
        2 3 1
      EOS
    end

    context 'p1' do
      let(:p_array) do
        [[1, 3, 2]]
      end

      it { is_expected.to eq [3, 2, 1] }
    end

    context 'p2' do
      let(:p_array) do
        [[2, 3, 1]]
      end

      it { is_expected.to eq [2, 3, 1] }
    end

    context 'p1 -> p2' do
      let(:p_array) do
        [[1, 3, 2], [2, 3, 1]]
      end

      it { is_expected.to eq [1, 3, 2] }
    end

    context 'p2 -> p1' do
      let(:p_array) do
        [[2, 3, 1], [1, 3, 2]]
      end

      it { is_expected.to eq [2, 1, 3] }
    end
  end

  describe '#patterns' do
    subject do
      progression = Progression.new(n, s, m, p_text)
      progression.replace_patterns
    end

    let(:n) { '3' }
    let(:s) { '3 1 2' }
    let(:m) { '2' }
    let(:p_text) do
      <<~EOS
        1 3 2
        2 3 1
      EOS
    end
    let(:exptected) do
      [[], [[1, 3, 2]], [[2, 3, 1]], [[1, 3, 2], [2, 3, 1]], [[2, 3, 1], [1, 3, 2]]]
    end

    it { is_expected.to eq exptected }
  end
end

# n個の数列
# m種類の置換
# 1回以下ずつ適用
# 辞書順で最小になるように適用したい
# 最大5回の置換
# 順序は問わない
# 適用してもしなくてもいい
#
# 組み合わせ最大は5C0 + 5C4 + 5C3 + 5C2 + 5C1 ってこと?
# 適用しない 1
# 1つ適用 5p1 = 5
# 2つ 5p2 5*4 = 20
# 3つ 5p3     = 60
# 4つ 5p4     = 120
# 5つ 5p5     = 120
# 1 + 5 + 20 + 60 + 120 + 120 = 326通り
# 最大326通りの配列を生むのがキモ
# 一番小さいのを取り出すのはソート出来そう
