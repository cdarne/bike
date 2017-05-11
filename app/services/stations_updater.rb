class StationsUpdater

  def update(source_url)
    data = fetch(source_url)
    stations = parse(data)
    filtered_stations = filter(stations)
    persist(filtered_stations)
  rescue

  end

  private

  def fetch(source_url)
    DataSourceFetcher.new(source_url).fetch
  end

  def parse(data)
    StationsParser.new(data).parse
  end

  # filter out blocked, suspended or out of service stations
  def filter(stations)
    stations.reject {|s| s['b'] || s['su'] || s['m'] }
  end

  def persist(stations)
    Station.transaction do
      Station.delete_all
      stations.each do |s|
        Station.create!(name: s['s'], latitude: s['la'], longitude: s['lo'], available_bikes: s['ba'])
      end
    end
  end
end
