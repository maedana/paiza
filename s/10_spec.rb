require 'rspec'
require File.join(File.dirname(__FILE__), '10.rb')

describe 'S002' do
  subject { f(input) }

  describe '入力例1' do
    let(:input) do
      <<~EOS
        4 5
        0 s 0 1
        0 0 1 0
        0 1 1 0
        0 0 1 g
        0 0 0 0
      EOS
    end
    it { is_expected.to eq '9' }
  end

  describe '入力例2' do
    let(:input) do
      <<~EOS
        4 4
        0 s 0 1
        1 0 0 0
        0 1 1 1
        0 0 0 g
      EOS
    end
    it { is_expected.to eq 'Fail' }
  end

  describe MinDistance do
    describe '#initialize' do
      subject(:mini_distance) do
        MinDistance.new(input)
      end

      let(:input) do
        <<~EOS
          4 5
          0 s 0 1
          0 0 1 0
          0 1 1 0
          0 0 1 g
          0 0 0 0
        EOS
      end

      describe '#m' do
        subject { super().m }

        it { is_expected.to eq 4 }
      end

      describe '#n' do
        subject { super().n }

        it { is_expected.to eq 5 }
      end

      describe '#s' do
        subject { super().s }

        it { is_expected.to eq [0, 1] }
      end

      describe '#g' do
        subject { super().g }

        it { is_expected.to eq [3, 3] }
      end

      describe '#rows' do
        subject { super().rows }

        let(:expected) do
          [
            %w(0 s 0 1),
            %w(0 0 1 0),
            %w(0 1 1 0),
            %w(0 0 1 g),
            %w(0 0 0 0)
          ]
        end
        it { is_expected.to eq expected }
      end
    end

    describe '#next_candidates' do
      subject do
        mini_distance = MinDistance.new(input)
        mini_distance.next_candidates(current_pos, visited)
      end

      let(:input) do
        <<~EOS
          4 5
          0 s 0 1
          0 0 1 0
          0 1 1 0
          0 0 1 g
          0 0 0 0
        EOS
      end

      context 'スタートの時' do
        let(:current_pos) { [0, 1] }
        let(:visited) { [] }
        let(:expected) do
          [
            [0, 0],
            [0, 2],
            [1, 1]
          ]
        end

        it { is_expected.to eq expected }
      end

      context '0, 0' do
        let(:current_pos) { [0, 0] }
        let(:visited) { [[0, 1]] }
        let(:expected) do
          [
            [1, 0]
          ]
        end

        it { is_expected.to eq expected }
      end

      context '1, 0' do
        let(:current_pos) { [1, 0] }
        let(:visited) { [[0, 1], [0, 0]] }
        let(:expected) do
          [
            [1, 1],
            [2, 0]
          ]
        end

        it { is_expected.to eq expected }
      end

      context '1, 1' do
        let(:current_pos) { [1, 1] }
        let(:visited) { [[0, 1], [0, 0], [1, 0]] }
        let(:expected) do
          []
        end

        it { is_expected.to eq expected }
      end

      context '2, 0' do
        let(:current_pos) { [2, 0] }
        let(:visited) { [[0, 1], [0, 0], [1, 0]] }
        let(:expected) do
          [
            [3, 0]
          ]
        end

        it { is_expected.to eq expected }
      end

      context '3, 0' do
        let(:current_pos) { [3, 0] }
        let(:visited) { [[0, 1], [0, 0], [1, 0], [2, 0]] }
        let(:expected) do
          [
            [3, 1],
            [4, 0]
          ]
        end

        it { is_expected.to eq expected }
      end
    end
  end
end

  # 各位置で出来ること
  # 上下左右への移動
  #   移動とは
  #     移動距離を1つ増やす
  #     通ったルートを保管?
  #   壁だったら終了
  #   ゴールだったら終了
  #     そこまでのルートを保管
  # 移動に必要な情報とは
  #   次の座標
  #   そこまでのルート
  # 座標候補の求め方
  #   任意の座標
  #   チャレンジ済みの方向?
