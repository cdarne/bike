namespace :data do
  desc 'Fetches the latest data from remote data source'
  task :update_from_remote => :environment do
    StationsUpdater.new.update(Rails.configuration.datasource['url'])
  end
end
