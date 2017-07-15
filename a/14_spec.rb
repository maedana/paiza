require 'rspec'
require File.join(File.dirname(__FILE__), '14.rb')

describe 'A-14' do
  subject { f(count, logs_text) }

  describe '入力例1' do
    let(:count) { 60 }
    let(:logs_text) do
      <<~EOS
        B 6 5
        W 4 6
        B 3 4
        W 4 3
        B 3 5
        W 6 6
        B 5 6
        W 2 6
        B 2 5
        W 1 6
        B 2 4
        W 7 6
        B 7 5
        W 6 4
        B 5 3
        W 6 3
        B 6 2
        W 4 2
        B 3 2
        W 2 3
        B 3 6
        W 3 7
        B 4 7
        W 5 7
        B 7 7
        W 6 7
        B 5 8
        W 4 8
        B 3 8
        W 2 8
        B 2 7
        W 1 7
        B 1 8
        W 7 8
        B 6 8
        W 8 7
        B 8 6
        W 8 4
        B 8 5
        W 8 8
        B 8 3
        W 5 2
        B 3 3
        W 7 4
        B 7 3
        W 7 2
        B 8 2
        W 7 1
        B 8 1
        W 2 2
        B 1 5
        W 1 4
        B 1 3
        W 1 2
        B 6 1
        W 5 1
        B 4 1
        W 3 1
        B 2 1
        W 1 1
      EOS
    end

    it { is_expected.to eq '38-26 The black won!' }
  end

  describe '入力例2' do
    let(:count) { 14 }
    let(:logs_text) do
      <<~EOS
        B 4 3
        W 5 3
        B 6 3
        W 3 3
        B 3 4
        W 3 5
        B 4 6
        W 7 3
        B 6 5
        W 7 5
        B 5 6
        W 5 7
        B 6 4
        W 7 4
      EOS
    end

    it { is_expected.to eq '00-18 The white won!' }
  end
end

describe Osero do
  describe 'new' do
    subject(:osero) { Osero.new(1, "B 4 3\n") }

    it { expect(osero.board[3][3]).to eq 'W' }
    it { expect(osero.board[3][4]).to eq 'B' }
    it { expect(osero.board[4][3]).to eq 'B' }
    it { expect(osero.board[4][4]).to eq 'W' }
  end

  describe 'logs' do
    subject { Osero.new(1, "B 4 3\nW 5 3\n").logs }

    it { is_expected.to eq [['B', 3, 2], ['W', 4, 2]] }
  end
end

# 先頭は手数数
# Bが黒
# Wが白
# Bが先手
# パスあり(打てるところがないときのみ)
# どちらが勝利か?
#
# 白の数
# 黒の数
# 大きい方
# ひとけたのときはゼロパディングする
# 黒が勝った時
# xx-yy The black won!
# 白が勝った時
# xx-yy The white won!
# 引き分けの時
# xx-yy Draw!
