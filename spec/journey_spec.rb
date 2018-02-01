require 'oystercard'

describe Journey do

  let(:card) {Oystercard.new}

  it 'touching in starts the journey' do
    expect(subject).to be_in_journey
  end

end
