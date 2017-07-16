require 'rspec'
require File.join(File.dirname(__FILE__), '157.rb')

describe 'S013' do
  subject { f(input) }

  describe '入力例1' do
    let(:input) do
      <<~EOS
        5
        5 10
        ssdss
      EOS
    end
    it { is_expected.to eq '5 2 3 4 1 5' }
  end

  describe '入力例2' do
    let(:input) do
      <<~EOS
        4
        18 12
        sdds
      EOS
    end
    it { is_expected.to eq '4 1 3 2 1 4' }
  end
end

describe TimeMacine do
  let(:input) do
    <<~EOS
      5
      5 10
      ssdss
    EOS
  end

  describe '#initialize' do
    subject(:time_macine) do
      TimeMacine.new(input)
    end

    it { expect(time_macine.n).to eq 5 }
    it { expect(time_macine.cf).to eq 5 }
    it { expect(time_macine.cb).to eq 10 }
    it { expect(time_macine.default_safeties).to eq [true, true, false, true, true] }
  end

  describe '#travel' do
    subject(:time_macine) do
      tm = TimeMacine.new(input)
      tm.travel([5], [1, 2, 4], tm.default_safeties)
      tm
    end

    let(:exptected) do
      [[5, 2, 3, 4, 1, 5], [5, 4, 2, 3, 1, 5]]
    end
    it { expect(time_macine.complete_routes).to eq exptected }
  end
end

describe Era do
  let(:input) do
    <<~EOS
      5
      5 10
      ssdss
    EOS
  end

  let(:time_macine) do
    TimeMacine.new(input)
  end

  describe '#to' do
    subject(:era) do
      era = Era.new([], time_macine.default_safeties)
      era.to(2)
      era
    end

    it { expect(era.safeties).to eq [true, true, true, false, false] }
    it { expect(era.visited).to eq [2] }
  end

  describe '#not_visited' do
    let(:era) do
      Era.new([5], time_macine.default_safeties)
    end

    context '移動前' do
      subject do
        era.not_visited
      end

      # true, true, false, true, true
      it { is_expected.to eq [1, 2, 4] }
    end

    context '2へ移動後' do
      subject do
        era.to(2)
        era.not_visited
      end

      # true, true, true, false, false
      it { is_expected.to eq [1, 3] }
    end

    context '2, 3へ移動後' do
      subject do
        era.to(2)
        era.to(3)
        era.not_visited
      end

      # true, true, true, true, true
      it { is_expected.to eq [1, 4] }
    end

    context '2, 3, 4へ移動後' do
      subject do
        era.to(2)
        era.to(3)
        era.to(4)
        era.not_visited
      end

      # true, true, true, true, false
      it { is_expected.to eq [1] }
    end

    context '2, 3, 4, 1へ移動後' do
      subject do
        era.to(2)
        era.to(3)
        era.to(4)
        era.to(1)
        era.not_visited
      end

      # true, false, false, false, true
      it { is_expected.to eq [] }
    end
  end
end

# 安全な時代しかいけない
# 同じ時代にはいけない。過去か未来のみ
# どれだけ離れていても一定のコスト
# 行き先より未来の安全/危険が全て逆転
# 同じ時代に何度でもいける
#
# 行き止まりになったら終了
# 全てわたって現代に戻れたら終了
# 全ルートを調べる
#   開始地点はN
#   総当りで調べる
#   飛んだところにvisited?
# ・2 ≦ N ≦ 7
# ・0 ≦ c_f, c_b ≦ 100
# ・ターゲットの時代をすべてまわって戻ってくるルートが少なくとも 1 つ必ず存在する
#
#=============
# 仕切りなおす
#=============
# 一個前の飛べる候補をメモ化?
#   一個前の飛べる候補がなくなるまで繰り返し?
#   次に飛ぶ場所、他に飛べた場所、飛ぶ前の安全状況?
#
# ある地点で見たときいけるのは何か
# 自分以外 かつ 安全な場所
#
# ある地点でみたとき終了出来るのは何か
# 安全な場所がない
# 全部回った
#   現在が危険
#     コストが低いところへ再度飛ぶ
#   現在が安全k
