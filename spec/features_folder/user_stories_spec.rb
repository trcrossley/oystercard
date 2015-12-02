require 'oystercard'

describe Oystercard do

let(:station){double :station}

  # In order to use public transport
  # As a customer
  # I want money on my card

  it 'card can store credit' do
    expect(subject.balance).to eq(0)
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  it 'card can be topped up' do
    expect { subject.top_up 1 }.to change{ subject.balance }.by 1
  end

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card

  it 'maximum limit of £90' do
    limit = Oystercard::CARD_LIMIT
    subject.top_up(90)
    expect { subject.top_up(1) }.to raise_error "card limit exceeded #{limit}"
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card

  it 'deducts fare from the card' do
    subject.top_up(20)
    subject.tap_in(station)
    expect{ subject.tap_out(station)}.to change{subject.balance}.by(-Oystercard::MIN_FARE)
  end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.

  describe '#tap_in' do
    it 'begins a trip' do
      subject.top_up(20)
      subject.tap_in(station)
      expect(subject).to be_in_transit
    end
  end

  describe '#tap_out' do
    it 'ends a trip' do
      subject.top_up(20)
      subject.tap_out(station)
      expect(subject).to_not be_in_transit
    end
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.

  it 'prevents tapping in' do
    expect{subject.tap_in(station)}.to raise_error "insufficient funds"
  end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card

  it 'deducts fare from the card' do
    subject.top_up(20)
    subject.tap_in(station)
    expect{ subject.tap_out(station)}.to change{subject.balance}.by(-Oystercard::MIN_FARE)
  end

  # In order to know where I have been
  # As a customer
  # I want to see to all my previous trips

end
