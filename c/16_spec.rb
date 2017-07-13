require 'rspec'
require File.join(File.dirname(__FILE__), '16.rb')

describe 'C-16' do
  subject { f(ips) }

  describe '入力例1' do
    let(:ips) do
      %w(
        192.168.0.1
        192.168.0.2
        192.168.0.3
        192.168.0.4
      )
    end
    it { is_expected.to eq "True\nTrue\nTrue\nTrue" }
  end

  describe '入力例2' do
    let(:ips) do
      %w(
        192.400.1.10.1000...
        4.3.2.1
        0..33.444...
        1.2.3.4
      )
    end
    it { is_expected.to eq "False\nTrue\nFalse\nTrue" }
  end

  describe '入力例3' do
    let(:ips) do
      %w(
        192.168.0.1
        192.168.0.2
        192.168.0.3
        192.168.0.4.5
      )
    end
    it { is_expected.to eq "True\nTrue\nTrue\nFalse" }
  end
end
