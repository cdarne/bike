class DataSourceFetcher
  DEFAULT_OPTIONS = { open_timeout: 5, read_timeout: 5 }

  def initialize(url)
    @url = url
  end

  def fetch
    f = open(@url, DEFAULT_OPTIONS)
    f.read
  rescue OpenURI::HTTPError => e
    raise FetchError, 'Error while fetching data: ' + e.message
  end

  class FetchError < StandardError
  end
end
