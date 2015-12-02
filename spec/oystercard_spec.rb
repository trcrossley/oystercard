require 'oystercard'

describe Oystercard do

let(:station){double :station}
let(:entry_station){double :station}
let(:exit_station){double :station}
let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do

    it 'can be topped up' do
      expect { subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'prevents exceeding card limit' do
      limit = Oystercard::CARD_LIMIT
      subject.top_up(90)
      expect { subject.top_up(1) }.to raise_error "card limit exceeded #{limit}"
    end
  end

  describe '#tap_in' do
    it 'begins a trip' do
      subject.top_up(20)
      subject.tap_in(station)
      expect(subject).to be_in_transit
    end

    it 'prevents tapping in' do
      expect{subject.tap_in(double :station)}.to raise_error "insufficient funds"
    end
  end

  describe '#tap_out' do
    it 'ends a trip' do
      subject.top_up(20)
      subject.tap_out(station)
      expect(subject).to_not be_in_transit
    end

    it 'deducts fare from the card' do
      subject.top_up(20)
      subject.tap_in(station)
      expect{ subject.tap_out(station)}.to change{subject.balance}.by(-Oystercard::MIN_FARE)
    end

    describe '#journey_log' do
      it 'holds a jouney log' do
        expect(subject.journeys).to be_empty
      end

      it 'stores the entry station' do
        subject.top_up(20)
        subject.tap_in(entry_station)
        subject.tap_out(exit_station)
        expect(subject.journeys[1]).to eq [entry_station, exit_station]
      end

      it 'stores the exit station' do
        subject.top_up(20)
        subject.tap_in(entry_station)
        subject.tap_out(exit_station)
        expect(subject.journeys[1]).to eq [entry_station, exit_station]
      end
    end

  end

  # describe '#journey' do
  #   before do
  #
  #   end
  # end
  #
  # describe '#in_transit?' do
  #   it 'is not in transit' do
  #     expect(subject).not_to be_in_transit
  #   end
  #
  #   it 'holds a journey log' do
  #     expect(subject.journeys).to be_empty
  #   end
  # end

end
