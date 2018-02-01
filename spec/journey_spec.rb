require 'oystercard'
require 'journey'

describe Journey do

  let(:card) {Oystercard.new}
  let(:station) { double("a station") }
  let(:station2) { double("another station") }

  let(:card_topped_up) do
    card.top_up(10)
    card
  end

  let(:card_touched_in) do
    card_topped_up
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

  # TODO: once journeys are stored in an array of journeys, can check the last journey was complete
  # it 'touching out finishes the journey' do
  #   card_touched_out
  #   expect(card_touched_out.current_journey).not_to be_in_journey
  # end

  it 'correctly stores the entry station' do
    expect(card_touched_in.current_journey.entry_station).to eq station
  end

  # TODO: once journeys are stored in an array of journeys, can check the last journey stored an exit station
  # it 'correctly stores the exit station' do
  #   expect(card_touched_out.current_journey.exit_station).to eq station2
  # end

  it 'should return min fare if there is an entry and exit station' do
    card_touched_in
    expect{card_touched_in.touch_out(station2)}.to change { card.balance }.by(-1)
  end

  it 'should charge a penalty fare if there is no exit station' do
    journey = card_touched_in.current_journey
    expect{journey.finish_journey(nil, card_touched_in)}.to change { card.balance }.by(-6)
  end

  it 'should charge a penalty fare if there is no entry station' do
    card_topped_up
    expect{card_topped_up.touch_out(station2)}.to change { card.balance }.by(-6)
  end
end
