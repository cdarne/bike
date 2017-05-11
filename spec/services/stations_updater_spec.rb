require 'rails_helper'

RSpec.describe StationsUpdater do

  def temp_file(content)
    f = Tempfile.new
    f << content
    f.flush
    f
  end

  describe 'update' do
    it 'insert parsed stations in the DB' do
      f = temp_file '{"stations":[{"s":"Station Test","b":false,"su":false,"m":false,"la":45.50931028555171,"lo":-73.55443105101585,"ba":12}]}'
      up = StationsUpdater.new
      expect { up.update(f.path) }.to change(Station, :count).by(1)
    end

    it 'removes old stations from the DB' do
      old_station = Station.create!(name: 'old', latitude: 45.0, longitude: 73.0, available_bikes: 5)
      f = temp_file '{"stations":[{"s":"Station Test","b":false,"su":false,"m":false,"la":45.50931028555171,"lo":-73.55443105101585,"ba":12}]}'
      up = StationsUpdater.new
      up.update(f.path)
      expect { old_station.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(Station.first.name).to eq('Station Test')
    end

    it 'filters out blocked, suspended or out of service stations' do
      f = temp_file <<JSON
      {"stations":[
        {"s":"Station good","b":false,"su":false,"m":false,"la":45.0,"lo":-73.00,"ba":1},
        {"s":"Station blocked","b":true,"su":false,"m":false,"la":45.0,"lo":-73.00,"ba":2},
        {"s":"Station suspended","b":false,"su":true,"m":false,"la":45.0,"lo":-73.00,"ba":3},
        {"s":"Station broken","b":false,"su":false,"m":true,"la":45.0,"lo":-73.00,"ba":4}
      ]}
JSON
      up = StationsUpdater.new
      up.update(f.path)
      expect(Station.count).to eq(1)
      expect(Station.first.name).to eq('Station good')
    end
  end
end
