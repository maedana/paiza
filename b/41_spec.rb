require 'rspec'
require File.join(File.dirname(__FILE__), '41.rb')

describe 'B-41' do
  subject { f(card_numbers) }

  describe '入力例' do
    let(:card_numbers) do
      %w(
        846087729128569X
      )
    end
    it { is_expected.to eq '7' }
  end

  describe '入力例' do
    let(:card_numbers) do
      %w(
        628381026148991X
        511070105176715X
        273492510450813X
        670891979616350X
      )
    end
    it { is_expected.to eq "5\n9\n7\n2" }
  end

  describe '入力例' do
    let(:card_numbers) do
      %w(
        091180422478189X
        774123801013511X
        973736969204716X
        793180803472918X
        358682935182058X
      )
    end
    it { is_expected.to eq "1\n4\n0\n1\n2" }
  end
end
