require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end
  describe '#top_up' do
    #it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can be topped up' do
      expect { subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'prevents exceeding card limit' do
      limit = Oystercard::CARD_LIMIT
      subject.top_up(90)
      expect { subject.top_up(1) }.to raise_error "card limit exceeded #{limit}"
    end
  end

  # describe '#deduct' do
  #   #it { is_expected.to respond_to(:deduct).with(1).argument }
  #
  #   it 'can deduct funds' do
  #     expect { subject.deduct(1) }.to change{ subject.balance }.by -1
  #   end
  # end

  describe '#tap_in' do
    it 'begins a trip' do
      subject.top_up(20)
      subject.tap_in
      expect(subject).to be_in_transit
    end

    it 'prevents tapping in' do
      subject.top_up(0) #REFACTOR
      expect{subject.tap_in}.to raise_error "insufficient funds"
    end
  end

  describe '#tap_out' do
    it 'ends a trip' do
      subject.top_up(20)
      subject.tap_out
      expect(subject).to_not be_in_transit
    end

    # it 'deducts fare from the card' do
    #   subject.top_up(20)
    #   subject.tap_in
    #   subject.tap_out
    #   expect{ subject.deduct(1)}.to change{subject.balance}.by -1
    # end

  end

  describe '#in_transit?' do
    it 'is not in transit' do
      expect(subject).not_to be_in_transit
    end
  end
end
