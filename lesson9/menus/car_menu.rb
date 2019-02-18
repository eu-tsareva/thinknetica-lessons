# frozen_string_literal: true

class CarMenu < Menu
  VARIANTS = {
    '1' => :add_car_to_train,
    '2' => :delete_car_from_train,
    '3' => :edit_car,
    '4' => :show_cars_in_train
  }.freeze

  private

  def print_menu
    puts ''
    puts 'Enter \'1\' to add car to existing train'
    puts 'Enter \'2\' to remove car from existing train'
    puts 'Enter \'3\' to take space/seat in train\'s car'
    puts 'Enter \'4\' to get a list of cars in a train'
    puts 'Enter \'0\' to return to previous menu'
  end

  def add_car_to_train
    train = choose_object('trains', trains, method(:add_car_to_train))
    return unless train

    train.add_car(create_car(train.type))
    puts "\nCar was added!\n"
  rescue ArgumentError => e
    puts "\n#{e.message}\nCar was not added! Try again!\n"
    add_car_to_train
  end

  def create_car(type)
    if type == :cargo
      CargoCar.new(gets_number('Enter space volume: '))
    else
      PassengerCar.new(gets_number('Enter number of seats: '))
    end
  end

  def delete_car_from_train
    train = choose_object('trains', trains, method(:delete_car_from_train))
    return unless train

    train.remove_last_car
    puts "\n Car was deleted!\n"
  end

  def edit_car
    train = choose_object('trains', trains, method(:edit_car))
    return unless train

    car = choose_object('cars', train.cars, method(:edit_car))
    return unless car

    car.type == :cargo ? take_space(car) : take_seat(car)
  end

  def take_space(car)
    space = gets_number('Enter how much space to take: ')
    if car.take_space(space)
      puts "Space was taken!\n"
    else
      puts "Space was not taken! Try again!\n"
      edit_car
    end
  end

  def take_seat(car)
    if car.take_seat
      puts "Seat was taken!\n"
    else
      puts "Seat was not taken! Try again!\n"
      edit_car
    end
  end

  def show_cars_in_train
    train = choose_object('trains', trains, method(:show_cars_in_train))
    return unless train

    if train.cars.any?
      train.each_car_with_index { |car, index| puts "#{index}. #{car.info}" }
    else
      puts "There are no cars yet.\n"
    end
  end
end
