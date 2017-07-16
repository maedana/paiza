require 'rspec'
require File.join(File.dirname(__FILE__), '15.rb')

describe 'S-15' do
  subject { f(k, s, t) }

  describe '入力例1' do
    let(:k) { '2' }
    let(:s) { '3' }
    let(:t) { '6' }
    it { is_expected.to eq 'BCBA' }
  end

  describe '入力例2' do
    let(:k) { '10' }
    let(:s) { '123' }
    let(:t) { '139' }
    it { is_expected.to eq 'BAAABCBABCCBAABCB' }
  end

  describe '入力例3' do
    let(:k) { '2' }
    let(:s) { '3' }
    let(:t) { '9' }
    it { is_expected.to eq 'BCBABCC' }
  end
end

describe AbcStr do
  describe 'length' do
    subject do
      abc_str = AbcStr.new(k, '1', '2')
      abc_str.length[k.to_i]
    end

    context 'レベル1' do
      let(:k) { '1' }

      it { is_expected.to eq 3 }
    end

    context 'レベル2' do
      let(:k) { '2' }

      it { is_expected.to eq 9 }
    end

    context 'レベル3' do
      let(:k) { '3' }

      it { is_expected.to eq 21 }
    end

    context 'レベル100' do
      let(:k) { '100' }

      it { is_expected.to eq 3802951800684688204490109616125 }
    end
  end
end

# 整数k
# レベルk
# レベル1: 'ABC'
# レベル2: 'A' + 'ABC' + 'B' + 'ABC' + 'C'
# k, s, t
#
# つまり、レベルkの文字列の長さは、(レベルk - 1の文字列の長さ) * 2 + 3
# 45
# 45 * 2 + 3 = 93
# 93 * 2 + 3 = 189
# 先頭、中央、最後がそれぞれA, B, Cだとわかってる 
# AxBxC
# 各位置は左、中央、右のいずれかである。それがわかればABCがわかるということか?
# 'AABCBABCC'
# 'LLCRCLCRR'
# 'L LLCRCLCRR C LLCRCLCRR R'
# 左、中央、右でなければ一個前のレベルへを繰り返して特定か
# レベルが100あり、抽出対象文字が最大100個。つまり、100*100のループなので大したことなさそう
