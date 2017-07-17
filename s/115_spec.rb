require 'rspec'
require File.join(File.dirname(__FILE__), '115.rb')

describe 'S010' do
  subject { f(input) }

  describe '入力例1' do
    let(:input) do
      <<~EOS
        1 6 2 5 4 3
        4
        1
        5
        3
        4
      EOS
    end
    it { is_expected.to eq '4' }
  end

  describe '入力例2' do
    let(:input) do
      <<~EOS
        6 5 4 3 2 1
        6
        6
        2
        1
        3
        4
        3
      EOS
    end
    it { is_expected.to eq '8' }
  end

  describe Sugoroku do
    describe '#initialize' do
      subject(:sugoroku) do
        Sugoroku.new(input)
      end

      let(:input) do
        <<~EOS
          1 6 2 5 4 3
          4
          1
          5
          3
          4
        EOS
      end

      it { expect(sugoroku.t).to eq 1 }
      it { expect(sugoroku.b).to eq 6 }
      it { expect(sugoroku.u).to eq 2 }
      it { expect(sugoroku.d).to eq 5 }
      it { expect(sugoroku.l).to eq 4 }
      it { expect(sugoroku.r).to eq 3 }
      it { expect(sugoroku.n).to eq 4 }
      it { expect(sugoroku.p).to eq [1, 5, 3, 4] }
    end
  end
end

# さいころの性質
# 裏表を足すと7
# わかること、手前の数字(L)、ゴール側の数字(U), 上は(T)
#
# 7 - 次の数字
# ゴール側なら右回転
# 手前側なら手前回転
# 奥側なら奥回転
# 上側なら手前 or 奥に2回転
#
# 下側ならOK
# 後側なら 左回転
#
# 仕切り直し。目的の数字が下にあるときだけ2回、それ以外は1回でよい
