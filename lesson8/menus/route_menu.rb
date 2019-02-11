# frozen_string_literal: true

class RouteMenu < Menu
  VARIANTS = {
    '1' => :create_route,
    '2' => :add_station_to_route,
    '3' => :delete_station_from_route,
    '4' => :show_routes
  }.freeze

  private

  def print_menu
    puts ''
    puts 'Enter \'1\' to create route'
    puts 'Enter \'2\' to add station to existing route'
    puts 'Enter \'3\' to remove station from existing route'
    puts 'Enter \'4\' to get a list of routes'
    puts 'Enter \'0\' to return to previous menu'
  end

  def create_route
    unless enough_stations?
      puts 'You need to have at least two stations to create a route.'
      return
    end
    first_station, last_station = route_stations
    routes << Route.new(first_station, last_station)
    puts "\nRoute was created!\n"
  rescue ArgumentError => e
    puts "\n#{e.message}\nRoute was not created! Try again.\n"
    route_stations
  end

  def route_stations
    puts 'You have following stations:'
    show_stations
    init_index = gets_index('Enter initial station index: ')
    final_index = gets_index('Enter final station index: ')
    validate_stations!(init_index, final_index)
    [stations[init_index], stations[final_index]]
  end

  def add_station_to_route
    route = choose_object('routes', routes, method(:add_station_to_route))
    return unless route

    puts 'You have following stations:'
    show_stations
    station_index = gets_index('Enter station index: ')
    unless correct_index?(station_index, stations)
      puts "Wrong indexes. Try again.\n"
      add_station_to_route
    end
    puts route.add_station(stations[station_index]) ? SUCCESS_MSG : ERROR_MSG
  end

  def delete_station_from_route
    route = choose_object('routes', routes, method(:delete_station_from_route))
    return unless route

    puts 'You have following stations in this route:'
    route.show_stations
    index = gets_index('Enter station index you want to delete from route: ')
    puts route.delete_station(index) ? SUCCESS_MSG : ERROR_MSG
  end

  def validate_stations!(init_station, final_station)
    return if correct_index?(init_station, stations) &&
              correct_index?(final_station, stations)

    raise ArgumentError, 'Wrong indexes'
  end
end
