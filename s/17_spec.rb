require 'rspec'
require File.join(File.dirname(__FILE__), '17.rb')

describe 'S002' do
  subject { Liar.run(input) }

  describe '入力例1' do
    let(:input) do
      <<~EOS
        5 3
        1 said 3 was an honest person.
        2 said 3 was a liar.
        5 said 4 was an honest person.
      EOS
    end
    it { is_expected.to eq '3' }
  end

  describe '入力例2' do
    let(:input) do
      <<~EOS
        3 4
        3 said 2 was a liar.
        3 said 1 was a liar.
        1 said 1 was a liar.
        3 said 2 was an honest person.
      EOS
    end
    it { is_expected.to eq '-1' }
  end

  describe '入力例3' do
    let(:input) do
      <<~EOS
        3 3
        3 said 2 was a liar.
        3 said 1 was a liar.
        3 said 2 was an honest person.
      EOS
    end
    it { is_expected.to eq '-1' }
  end

  describe Liar do
    describe '#initialize' do
      subject(:liar) { Liar.new(n, m) }

      let(:n) { 10**3 }
      let(:m) { 10**6 }

      it { expect(liar.n).to eq 1_000 }
      it { expect(liar.m).to eq 1_000_000 }
    end

    describe '#load_memo' do
      subject do
        l = Liar.new(5, 3)
        l.load_memo(memo)
      end

      context '正直' do
        let(:memo) { '3 said 2 was an honest person.' }

        it { is_expected.to eq [3, 2, :h] }
      end

      context '嘘付' do
        let(:memo) { '3 said 2 was a liar' }

        it { is_expected.to eq [3, 2, :l] }
      end
    end

    describe '#store' do
      subject do
        liar.store(memo)
      end

      let(:liar) do
        l = Liar.new(5, 3)
        l.saids[4][1] = :h
        l.be_saids[1] = 4
        l
      end

      let(:memo) do
        [3, 2, :l]
      end

      describe '#saids' do
        subject do
          super()
          liar.saids
        end

        let(:expected) do
          h = Hash.new({})
          h[4] = { 1 => :h }
          h[3] = { 2 => :l }
          h
        end

        it { is_expected.to eq expected }
      end

      describe '#be_saids' do
        subject do
          super()
          liar.be_saids
        end

        let(:expected) do
          {1 => 4, 2 => 3}
        end

        it { is_expected.to eq expected }
      end
    end

    describe '#valid?' do
      subject do
        l = Liar.new(5, 3)
        l.saids = saids
        l.valid?(memo)
      end

      context '正常' do
        let(:saids) { Hash.new({}) }
        let(:memo) { [1, 1, :h] }

        it { is_expected.to eq true }
      end

      context '嘘付きのパラドックス' do
        let(:saids) { Hash.new({}) }
        let(:memo) { [1, 1, :l] }

        it { is_expected.to eq false }
      end

      context '正直かつ嘘付きになる' do
        let(:saids) do
          h = Hash.new({})
          h[3] = { 2 => :h }
          h[1] = { 2 => :l }
          h
        end
        let(:memo) { [1, 2, :h] }

        it { is_expected.to eq false }
      end

      context '嘘付きかつ正直になる' do
        let(:saids) do
          h = Hash.new({})
          h[3] = { 2 => :h }
          h[1] = { 2 => :h }
          h
        end
        let(:memo) { [1, 2, :l] }

        it { is_expected.to eq false }
      end
    end
  end
end

# ある人が発言する場合4パターン
# 1.自分を正直だという
# 2.自分を嘘付だという => 嘘付きのパラドックス
# 3.他人を正直だという
# 4.他人を嘘付だという
#
# 3.4. を同時にみたさない。他人を嘘付きかつ正直というのは出来ない
# 2. 自分を嘘付きだというのは出来ない

# 例では
