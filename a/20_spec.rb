require 'rspec'
require File.join(File.dirname(__FILE__), '20.rb')

describe 'A-20' do
  subject { f(l, n, m, line_text) }

  describe '入力例1' do
    let(:l) { 7 }
    let(:n) { 4 }
    let(:m) { 5 }
    let(:line_text) do
      <<~EOS
        1 3 1
        3 2 2
        2 3 5
        3 4 4
        1 6 6
      EOS
    end
    it { is_expected.to eq 3 }
  end

  describe '入力例1' do
    let(:l) { 5 }
    let(:n) { 5 }
    let(:m) { 8 }
    let(:line_text) do
      <<~EOS
        3 3 4
        1 3 2
        4 2 2
        2 1 2
        2 4 4
        3 1 1
        1 4 3
        4 3 4
      EOS
    end
    it { is_expected.to eq 1 }
  end
end

describe AmidaTree do
  describe 'sorted_tree' do
    subject { amida_tree.sorted_tree }

    let(:amida_tree) do
      AmidaTree.new('7', '4', '5', line_text)
    end

    let(:line_text) do
      <<~EOS
        1 3 1
        3 2 2
        2 3 5
        3 4 4
        1 6 6
      EOS
    end

    let(:expected_hash) do
      {
        1 => [
          [1, 6, 6],
          [1, 3, 1]
        ],
        2 => [
          [2, 3, 5]
        ],
        3 => [
          [3, 4, 4],
          [3, 2, 2]
        ]
      }
    end

    it { is_expected.to eq expected_hash }
  end

  describe '[]' do
    subject { amida_tree[1] }

    let(:amida_tree) do
      AmidaTree.new('7', '4', '5', line_text)
    end

    let(:line_text) do
      <<~EOS
        1 3 1
        3 2 2
        2 3 5
        3 4 4
        1 6 6
      EOS
    end

    it { is_expected.to eq [[1, 6, 6], [1, 3, 1]] }
  end
end
