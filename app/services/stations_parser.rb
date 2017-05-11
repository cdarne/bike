class StationsParser
  def initialize(data)
    @data = data
  end

  def parse
    parsed_data = JSON.parse(@data)
    parsed_data['stations'] || []
  rescue JSON::ParserError => e
    raise ParseError, 'Invalid source format: ' + e.message
  end

  class ParseError < StandardError
  end
end
