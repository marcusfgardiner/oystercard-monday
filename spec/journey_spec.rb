require 'oystercard'
require 'journey'

describe Journey do

  let(:card) {Oystercard.new}
  let(:station) { double("a station") }
  let(:station2) { double("another station") }

  let(:card_touched_in) do
    card.top_up(10)
    card.touch_in(station)
    card
  end

  let(:card_touched_out) do
    card_touched_in.touch_out(station2)
    card_touched_in
  end

  it 'touching in starts the journey' do
    expect(card_touched_in.current_journey).to be_in_journey
  end

  it 'touching out finishes the journey' do
    card_touched_out
    expect(card_touched_out.current_journey).not_to be_in_journey
  end

  it 'correctly stores the entry station' do
    expect(card_touched_in.current_journey.entry_station).to eq station
  end

  it 'correctly stores the exit station' do
    expect(card_touched_out.current_journey.exit_station).to eq station2
  end

  it 'should return min fare if there is an entry and exit station' do
    expect(card_touched_out.fare).to change { card.balance }.by(-Oystercard::MIN_CHARGE)
  end

end
