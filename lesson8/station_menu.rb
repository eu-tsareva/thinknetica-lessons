class StationMenu < Menu
  VARIANTS = {
    '1' => :create_station,
    '2' => :show_stations,
    '3' => :show_station_trains
  }.freeze

  private

  def print_menu
    puts ''
    puts 'Enter \'1\' to create station'
    puts 'Enter \'2\' to get a list of all stations'
    puts 'Enter \'3\' to get a list of trains at station'
    puts 'Enter \'0\' to return to previous menu'
  end

  def create_station
    station_name = gets_text('Enter station name: ')
    stations << Station.new(station_name)
    puts "\nStation was created!"
  rescue ArgumentError => e
    puts "\n#{e.message}"
    puts 'Station was not created! Try again!'
    create_station
  end

  def show_station_trains
    station = choose_object('stations', stations, method(:show_station_trains))
    return unless station

    if station.trains.any?
      puts "Trains at station #{station.name}: "
      station.each_train_with_index { |train, i| puts "#{i}. #{train.info}" }
    else
      puts 'There are no trains at this station.'
    end
  end
end
