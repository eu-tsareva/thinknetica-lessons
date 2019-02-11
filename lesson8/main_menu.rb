class MainMenu < Menu
  VARIANTS = {
    '1' => :start_station_menu,
    '2' => :start_route_menu,
    '3' => :start_train_menu,
    '4' => :start_car_menu
  }.freeze

  def initialize(options = {})
    super(options)

    @station_menu = StationMenu.new(options)
    @route_menu = RouteMenu.new(options)
    @train_menu = TrainMenu.new(options)
    @car_menu = CarMenu.new(options)
  end

  def print_menu
    puts ''
    puts 'Choose action:'
    puts 'Enter \'1\' to work with stations'
    puts 'Enter \'2\' to work with routes'
    puts 'Enter \'3\' to work with trains'
    puts 'Enter \'0\' to exit'
  end

  def start_station_menu
    @station_menu.start
  end

  def start_route_menu
    @route_menu.start
  end

  def start_train_menu
    @train_menu.start
  end

  def start_car_menu
    @car_menu.start
  end
end
