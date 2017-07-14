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

describe 'abc' do
  subject { abc(line_text) }

  let(:line_text) do
    <<~EOS
      1 3 1
      3 2 2
    EOS
  end

  it { is_expected.to eq [[1,3], [3,2], [1,2]]}
end

describe 'find_horizontal_bottom_line' do
  subject { find_bottom(current_position_v, current_position_h, remaining_lines, 4) }

  context 'パターン1' do
    let(:current_position_h) { 1 }
    let(:current_position_v) { 7 }

    let(:remaining_lines) do
      [
        [1, 3, 1],
        [3, 2, 2],
        [2, 3, 5],
        [3, 4, 4],
        [1, 6, 6]
      ]
    end

    it { is_expected.to eq [1, 6, 6] }
  end

  context 'パターン2' do
    let(:current_position_h) { 2 }
    let(:current_position_v) { 6 }

    let(:remaining_lines) do
      [
        [1, 3, 1],
        [3, 2, 2],
        [2, 3, 5],
        [3, 4, 4]
      ]
    end

    it { is_expected.to eq [2, 3, 5] }
  end

  context 'パターン3' do
    let(:current_position_h) { 3 }
    let(:current_position_v) { 5 }

    let(:remaining_lines) do
      [
        [1, 3, 1],
        [3, 2, 2],
        [3, 4, 4]
      ]
    end

    it { is_expected.to eq [3, 4, 4] }
  end

  context 'パターン4' do
    let(:current_position_h) { 4 }
    let(:current_position_v) { 4 }

    let(:remaining_lines) do
      [
        [1, 3, 1],
        [3, 2, 2]
      ]
    end

    it { is_expected.to eq [3, 2, 2] }
  end

  context 'パターン5' do
    let(:current_position_h) { 4 }
    let(:current_position_v) { 4 }

    let(:remaining_lines) do
      [
        [1, 3, 1]
      ]
    end

    it { is_expected.to be_nil }
  end

  context 'パターン6' do
    let(:current_position_v) { 5 }
    let(:current_position_h) { 1 }

    let(:remaining_lines) do
      [
        [3, 3, 4],
        [1, 3, 2],
        [4, 2, 2],
        [2, 1, 2],
        [2, 4, 4],
        [3, 1, 1],
        [1, 4, 3],
        [4, 3, 4]
      ]
    end

    it { is_expected.to eq [1, 4, 3] }
  end

  context 'パターン7' do
    let(:current_position_v) { 3 }
    let(:current_position_h) { 2 }

    let(:remaining_lines) do
      [
        [3, 3, 4],
        [1, 3, 2],
        [4, 2, 2],
        [2, 1, 2],
        [2, 4, 4],
        [3, 1, 1],
        [4, 3, 4]
      ]
    end

    it { is_expected.to eq [1, 3, 2] }
  end

  context 'パターン8' do
    let(:current_position_v) { 2 }
    let(:current_position_h) { 1 }

    let(:remaining_lines) do
      [
        [3, 3, 4],
        [4, 2, 2],
        [2, 1, 2],
        [2, 4, 4],
        [3, 1, 1],
        [4, 3, 4]
      ]
    end

    it { is_expected.to be_nil }
  end
end

describe 'lines' do
  subject { lines(line_text) }

  let(:line_text) do
    <<~EOS
      1 3 1
      3 2 2
    EOS
  end

  it { is_expected.to eq [[1,3,1], [3,2,2]]}
end
