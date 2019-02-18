# frozen_string_literal: true

class Menu
  SUCCESS_MSG = 'SUCCESS!'
  ERROR_MSG = 'ERROR!'

  def initialize(options = {})
    @stations = options[:stations] || []
    @trains = options[:trains] || []
    @routes = options[:routes] || []
  end

  def start
    loop do
      print_menu
      index = gets_text
      break if index == '0'

      proccess_choice(index)
    end
  end

  private

  attr_reader :stations
  attr_reader :routes
  attr_reader :trains

  def proccess_choice(index)
    func = self.class::VARIANTS[index]
    func ? send(func) : puts("Wrong input\n")
  end

  def choose_object(name, array, callback)
    unless array.any?
      puts "You don\'t have any #{name}"
      return
    end
    return array[0] if array.size == 1

    show_list(name, array)
    process_answer(array, callback)
  end

  def show_list(name, array)
    puts "You have following #{name}:"
    list = {
      trains: :show_trains,
      routes: :show_routes,
      stations: :show_stations,
      cars: :show_cars
    }[name.to_sym]
    name == 'cars' ? send(list, array) : send(list)
  end

  def process_answer(array, callback)
    index = gets_index('Choose index: ')
    unless correct_index?(index, array)
      puts "Wrong index. Try again.\n"
      callback.call
    end
    array[index]
  end

  def show_stations
    if stations.any?
      stations.each.with_index(1) do |station, index|
        puts "#{index}. #{station.name}"
      end
    else
      puts "There are no stations yet.\n"
    end
  end

  def show_routes
    if routes.any?
      routes.each.with_index(1) do |route, index|
        puts "#{index}) Route with stations:"
        route.show_stations
      end
    else
      puts "There are no routes yet.\n"
    end
  end

  def show_trains
    if trains.any?
      trains.each.with_index(1) { |train, index| puts "#{index} #{train.info}" }
    else
      puts "There are no trains yet.\n"
    end
  end

  def show_cars(cars)
    if cars.any?
      cars.each.with_index(1) { |car, index| puts "#{index} #{car.info}" }
    else
      puts "There are no cars yet.\n"
    end
  end

  def correct_index?(index, array)
    (0...array.size).cover?(index)
  end

  def enough_stations?
    stations.size >= 2
  end

  def gets_text(msg = '')
    msg && print(msg)
    gets.chomp
  end

  def gets_number(msg = '')
    msg && print(msg)
    gets.chomp.to_i
  end

  def gets_index(msg = '')
    gets_number(msg) - 1
  end
end
