require 'rspec'
require File.join(File.dirname(__FILE__), '50.rb')

describe MirrorBox do
end

describe 'A-50' do
  subject { f(h, w, boxes_text) }

  describe '入力例1' do
    let(:h) { '3' }
    let(:w) { '5' }
    let(:boxes_text) do
      <<~EOS
        __\\_/
        ___/_
        \\/\\_/
      EOS
    end
    it { is_expected.to eq 9 }
  end

  describe '入力例2' do
    let(:h) { '4' }
    let(:w) { '4' }
    let(:boxes_text) do
      <<~EOS
        ___\\
        _\\__
        ____
        _\\_/
      EOS
    end
    it { is_expected.to eq 12 }
  end

  describe '入力例3' do
    let(:h) { '3' }
    let(:w) { '2' }
    let(:boxes_text) do
      <<~EOS
        _\\
        //
        \\/
      EOS
    end
    it { is_expected.to eq 7 }
  end
end

# _ : 鏡なし
# / : 鏡あり
# \ : 鏡あり
# 高さ(h)と幅(w)
