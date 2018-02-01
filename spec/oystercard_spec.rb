require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new }

  let(:station) { double "a station" }
  let(:station2) { double "a second station" }

  let(:card_touched_in) do
    card.top_up(10)
    card.touch_in(station)
    card
  end
  let(:card_touched_out) do
    card_touched_in.touch_out(station2)
    card_touched_in
  end

  describe 'balance' do
    it 'when initialized has a balance of 0' do
      expect(card.balance).to be_zero
    end

    it 'raises error when Oystercard balance is greater than 90 pounds' do
      balance_limit = Oystercard::BALANCE_LIMIT
      card.top_up(balance_limit)
      message = "Error - maximum balance is #{balance_limit} pounds"
      expect { card.top_up(1) }.to raise_error(message)
    end
  end

  describe '#touch in' do

    it 'prevents touching in when balance is below one pound' do
      minimum_balance = Oystercard::BALANCE_MIN
      message = "Insufficient funds - minimum balance is #{minimum_balance}"
      expect { card.touch_in(station) }.to raise_error message
    end

  end

  describe '#touch out' do

    xit 'deducts the minimum fare' do
      card_touched_out
      expect { card_touched_out(station) }.to change { card.balance }.by(-Oystercard::BALANCE_MIN)
    end

  end

  describe '#top_up' do
    it 'adjusts balance by top up amount' do
      expect { card.top_up(1) }.to change { card.balance }.by(1)
    end
  end

  describe '#journey_history' do
    it 'starts off as being empty' do
      expect(card.journey_history).to eq []
    end

    it 'stores the last journey' do
      expect(card_touched_out.journey_history).to eq [{"Entry Station: " => station, "Exit Station: " => station2}]
    end
  end
end
