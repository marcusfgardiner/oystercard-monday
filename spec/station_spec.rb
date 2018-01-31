require 'station'

describe Station do

  subject(:station) { described_class.new(:Bakerpoo, 1) }
  subject(:card) { described_class.new }

  it "stores its station" do
    expect(station.name).to eq :Bakerpoo
  end

  it "stores its zone" do
    expect(station.zone).to eq 1
  end

  # it 'returns a specific station-zone combination' do
  #   expect(TODO: change this).to include(:bakerpoo => 1)
  # end
end
