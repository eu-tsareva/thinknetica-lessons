class ControlPanel
  def initialize
    @stations = []
    @routes = []
    @trains = []
    main_menu
  end

  private
  attr_reader :stations
  attr_reader :routes
  attr_reader :trains

  def main_menu
    loop do
      show_main_menu
      case gets.chomp
      when '1' then station_menu
      when '2' then route_menu
      when '3' then train_menu
      when '0' then break
      else puts 'Wrong input'
      end
    end
  end

  def show_main_menu
    puts ''
    puts 'Choose action:'
    puts 'Enter \'1\' to work with stations'
    puts 'Enter \'2\' to work with routes'
    puts 'Enter \'3\' to work with trains'
    puts 'Enter \'0\' to exit'
  end

  def station_menu
    loop do
      show_station_menu
      case gets.chomp
      when '1' then create_station
      when '2' then show_stations
      when '0' then break
      else puts 'Wrong input'
      end
    end
  end

  def show_station_menu
    puts ''
    puts 'Enter \'1\' to create station'
    puts 'Enter \'2\' to get a list of all stations'
    puts 'Enter \'0\' to return to previous menu'
  end

  def route_menu
    loop do
      show_route_menu
      case gets.chomp
      when '1' then create_route
      when '2' then add_station_to_route
      when '3' then delete_station_from_route
      when '4' then show_routes
      when '0' then break
      else puts 'Wrong input'
      end
    end
  end

  def show_route_menu
    puts ''
    puts 'Enter \'1\' to create route'
    puts 'Enter \'2\' to add station to existing route'
    puts 'Enter \'3\' to remove station from existing route'
    puts 'Enter \'4\' to get a list of routes'
    puts 'Enter \'0\' to return to previous menu'
  end

  def train_menu
    loop do
      show_train_menu
      case gets.chomp
      when '1' then create_train
      when '2' then add_car_to_train
      when '3' then delete_car_from_train
      when '4' then show_trains
      when '5' then show_trains_at_station
      when '6' then add_route_to_train
      when '7' then move_train_forwards
      when '8' then move_train_backwards
      when '0' then break
      else puts 'Wrong input'
      end
    end
  end

  def show_train_menu
    puts ''
    puts 'Enter \'1\' to create train'
    puts 'Enter \'2\' to add car to existing train'
    puts 'Enter \'3\' to remove car from existing train'
    puts 'Enter \'4\' to get a list of trains'
    puts 'Enter \'5\' to get a list of trains at station'
    puts 'Enter \'6\' to add route to existing train'
    puts 'Enter \'7\' to move train forwards'
    puts 'Enter \'8\' to move train backwards'
    puts 'Enter \'0\' to return to previous menu'
  end

  def create_station
    print 'Enter station name: '
    stations << Station.new(gets.chomp)
    puts "\nStation was created!"
  rescue ArgumentError => e
    puts "\n#{e.message}"
    puts "Station was not created! Try again!"
    create_station
  end

  def show_stations
    if stations.any?
      stations.each.with_index(1) { |station, index| puts "#{index}. #{station.name}" }
    else
      puts 'There are no stations yet.'
    end
  end

  def create_route
    unless enough_stations?
      puts 'You need to have at least two stations to create a route '
      return
    end

    puts 'You have following stations:'
    show_stations
    print 'Enter initial station index: '
    init_index = gets.chomp.to_i - 1
    print 'Enter final station index: '
    final_index = gets.chomp.to_i - 1

    validate_stations!(init_index, final_index)
    routes << Route.new(stations[init_index], stations[final_index])
    puts "\nRoute was created!"
  rescue ArgumentError => e
    puts "\n#{e.message}"
    puts 'Route was not created! Try again.'
    create_route
  end

  def add_station_to_route
    route = choose_object('routes', routes, method(:add_station_to_route))
    return unless route
    puts 'You have following stations:'
    show_stations
    print 'Enter station index: '
    station_index = gets.chomp.to_i - 1
    unless correct_index?(station_index, stations)
      puts 'Wrong indexes. Try again.'
      add_station_to_route
    end
    puts route.add_station(stations[station_index]) ?  "\nStation was added!" : "\nThere was an error! Station was not added!"
  end

  def delete_station_from_route
    route = choose_object('routes', routes, method(:delete_station_from_route))
    return unless route
    puts 'You have following stations in this route:'
    route.show_stations
    print 'Enter station index you want to delete from route: '
    station_index = gets.chomp.to_i - 1
    puts route.delete_station(station_index) ? "\nStation was deleted!" : "\nThere was an error! Station was not deleted!"
  end

  def show_routes
    if routes.any?
      routes.each.with_index(1) do |route, index|
        puts "#{index}) Route with stations:"
        route.show_stations
      end
    else
      puts 'There are no routes yet.'
    end
  end

  def create_train
    print 'Enter train number: '
    number = gets.chomp
    print 'Enter train type (cargo or passenger): '
    type = gets.chomp
    validate_train!(type)

    train = type == 'cargo' ? CargoTrain.new(number) : PassengerTrain.new(number)
    trains << train
    puts "\n#{type.capitalize} train #{number} was created!"

  rescue ArgumentError => e
    puts "\n#{e.message}"
    puts 'Train was not created! Try again!'
    create_train
  end

  def add_car_to_train
    train = choose_object('trains', trains, method(:add_car_to_train))
    return unless train
    car = train.type == :cargo ? CargoCar.new : PassengerCar.new
    train.add_car(car)
    puts "\n Car was added!"
  end

  def delete_car_from_train
    train = choose_object('trains', trains, method(:delete_car_from_train))
    return unless train
    train.remove_last_car
    puts "\n Car was deleted!"
  end

  def show_trains
    if trains.any?
      trains.each.with_index(1) { |train, index| puts "#{index}. #{train.info}" }
    else
      puts 'There are no trains yet.'
    end
  end

  def show_trains_at_station
    station = choose_object('stations', stations, method(:show_trains_at_station))
    return unless station
    if station.trains.any?
      puts "Trains at station #{station.name}: "
      station.trains.each.with_index(1) { |train, index| puts "#{index}. #{train.number}"}
    else
      puts 'There are no trains at this station.'
    end
  end

  def add_route_to_train
    train = choose_object('trains', trains, method(:add_route_to_train))
    route = choose_object('routes', routes, method(:add_route_to_train))
    return unless train && route
    train.route = route
    puts "\n Route was added to a train!"
  end

  def move_train_forwards
    train = choose_object('trains', trains, method(:move_train_forwards))
    return unless train
    train.go_forwards
    puts "Train moved forwards!"
  end

  def move_train_backwards
    train = choose_object('trains', trains, method(:move_train_backwards))
    return unless train
    train.go_backwards
    puts "Train moved backwards!"
  end

  def choose_object(name, array, callback)
    unless array.any?
      puts "You don\'t have any #{name}"
      return
    end

    return array[0] if array.size == 1

    puts "You have following #{name}:"
    case name
    when 'trains' then show_trains
    when 'routes' then show_routes
    when 'stations' then show_stations
    end
    print 'Choose index: '
    index = gets.chomp.to_i - 1
    unless correct_index?(index, array)
      puts 'Wrong index. Try again.'
      callback.call
    end
    array[index]
  end

  private

  def correct_index?(index, array)
    (0..array.size - 1).include?(index)
  end

  def validate_stations!(init_station, final_station)
    raise ArgumentError.new('Wrong indexes') unless correct_index?(init_station, stations) && correct_index?(final_station, stations)
  end

  def enough_stations?
    stations.size >= 2
  end

  def validate_train!(type)
    raise ArgumentError.new('Wrong type! Should be \'cargo\' or \'passenger\'') unless ['cargo', 'passenger'].include?(type)
  end
end
