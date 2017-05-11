require 'rails_helper'

RSpec.describe DataSourceFetcher do

  describe 'fetch' do
    it 'opens the provided url' do
      url = 'DL URL'
      dsf = DataSourceFetcher.new(url)
      expect(dsf).to receive(:open).with(url, DataSourceFetcher::DEFAULT_OPTIONS).and_return(StringIO.new)
      dsf.fetch
    end

    it 'returns data from the remote source' do
      data = 'some data'
      dsf = DataSourceFetcher.new('test')
      expect(dsf).to receive(:open).and_return(StringIO.new(data))
      expect(dsf.fetch).to eq(data)
    end

    it 'raises an error when open fails' do
      dsf = DataSourceFetcher.new('test')
      expect(dsf).to receive(:open).and_raise(OpenURI::HTTPError.new('error', StringIO.new))
      expect { dsf.fetch }.to raise_error(DataSourceFetcher::FetchError, 'Error while fetching data: error')
    end
  end
end
