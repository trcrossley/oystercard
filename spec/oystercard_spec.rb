require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end
  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can be topped up' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end

  # it 'can be topped up' do
  # end
end

# /Users/tristancrossley/Documents/oystercard/spec/oystercard_spec.rb:1:in `<top (required)>': uninitialized constant Oystercard (NameError)