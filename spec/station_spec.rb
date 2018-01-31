require 'station'

describe Station do

  it 'returns a specific station-zone combination' do
    expect(described_class::STATIONS_LIST).to include(:bakerpoo => 1)
  end
end
