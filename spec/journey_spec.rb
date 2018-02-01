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
    card_touched_in
    expect(subject).to be_in_journey
  end

  it 'touching out finishes the journey' do
    card_touched_out
    expect(subject).not_to be_in_journey
  end

end
