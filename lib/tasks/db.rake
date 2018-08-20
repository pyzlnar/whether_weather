namespace :db do
  # Data not included in the repo but can be found in
  # http://bulk.openweathermap.org/sample/city.list.json.gz
  desc 'Imports cities from db/data/cities.list.json file'
  task import_cities: :environment do
    path = Rails.root.join('db', 'data', 'city.list.json')
    file = File.read(path)
    json = JSON.parse(file)

    puts 'Reseting city table...'
    City.delete_all

    puts 'Parsing cities...'
    cities = json.each_with_object([]) do |city, a|
      a << {
        name:            city['name'],
        open_weather_id: city['id']
      }
    end

    total = cities.count
    puts "Saving #{total} cities, please wait a moment..."
    batch = 1000
    cities.in_groups_of(batch, false).each_with_index do |group, i|
      City.create(group)
      processed = batch * (i + 1)
      percent   = processed * 100 / total
      print "Progress (~#{percent}%) #{processed}/#{total} cities\r"
    end

    puts "\nDone!"
  end
end
