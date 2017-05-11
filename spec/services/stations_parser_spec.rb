require 'rails_helper'

RSpec.describe StationsParser do

  describe 'parse' do
    it 'returns the parsed stations' do
      json = '{"stations":[{"id":1,"s":"Station Test","n":"6001","st":1,"b":false,"su":false,"m":false,"lu":1494370240838,"lc":1494376186429,"bk":false,"bl":false,"la":45.50931028555171,"lo":-73.55443105101585,"da":19,"dx":0,"ba":12,"bx":0}]}'
      p = StationsParser.new(json)
      stations = p.parse
      expect(stations.length).to eq(1)
      station = stations.first
      expect(station['s']).to eq('Station Test')
      expect(station['la']).to eq(45.50931028555171)
      expect(station['lo']).to eq(-73.55443105101585)
      expect(station['ba']).to eq(12)
    end

    it 'raises an error when JSON parsing fails' do
      p = StationsParser.new('asdasdas')
      expect { p.parse }.to raise_error StationsParser::ParseError, "Invalid source format: 743: unexpected token at 'asdasdas'"
    end

    it 'returns an empty array when no stations are in the JSON' do
      p = StationsParser.new('{}')
      expect(p.parse).to eq([])
    end
  end
end
