class TrainMenu < Menu
  VARIANTS = {
    '1' => :create_train,
    '2' => :show_trains,
    '3' => :add_route_to_train,
    '4' => :move_train_forwards,
    '5' => :move_train_backwards
  }.freeze

  private

  def print_menu
    puts 'Enter \'1\' to create train'
    puts 'Enter \'2\' to get a list of trains'
    puts 'Enter \'3\' to add route to existing train'
    puts 'Enter \'4\' to move train forwards'
    puts 'Enter \'5\' to move train backwards'
    puts 'Enter \'0\' to return to previous menu'
  end

  def create_train
    number = gets_text('Enter train number: ')
    type = gets_text('Enter train type (cargo or passenger): ')
    validate_train!(type)
    train = type == 'cargo' ? CargoTrain.new(number) : PassengerTrain.new(number)
    trains << train
    puts "\n#{type.capitalize} train #{number} was created!\n"
  rescue ArgumentError => e
    puts "\n#{e.message}\nTrain was not created! Try again!\n"
    create_train
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
    puts 'Train moved forwards!'
  end

  def move_train_backwards
    train = choose_object('trains', trains, method(:move_train_backwards))
    return unless train

    train.go_backwards
    puts 'Train moved backwards!'
  end

  def validate_train!(type)
    return if %w[cargo passenger].include?(type)

    raise ArgumentError, 'Wrong type! Should be \'cargo\' or \'passenger\''
  end
end
