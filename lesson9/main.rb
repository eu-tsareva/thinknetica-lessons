# frozen_string_literal: true

require_relative 'instance_counter.rb'
require_relative 'validation.rb'
require_relative 'accessors.rb'
require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'manufacturer.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'cargo_train.rb'
require_relative 'car.rb'
require_relative 'passenger_car.rb'
require_relative 'cargo_car.rb'
require_relative 'menus/menu.rb'
require_relative 'menus/station_menu.rb'
require_relative 'menus/route_menu.rb'
require_relative 'menus/train_menu.rb'
require_relative 'menus/car_menu.rb'
require_relative 'menus/main_menu.rb'
require_relative 'control_panel.rb'

# ControlPanel.new

p 'cargo car'
p 'Invalid tests:'
begin
  p '1. Validate space type'
  CargoCar.new('300')
rescue TypeError => e
  p "Error: #{e.message}"
end

begin
  p '2. Validate space presence '
  cargo_car = CargoCar.new(300)
  cargo_car.instance_eval '@space = nil', __FILE__, __LINE__
  cargo_car.validate!
rescue ArgumentError => e
  p "Error: #{e.message}"
end

begin
  p '3. Validate number type'
  cargo_car = CargoCar.new(300)
  cargo_car.number = '34'
  cargo_car.validate!
rescue TypeError => e
  p "Error: #{e.message}"
end

p 'Valid tests:'
cargo_car = CargoCar.new(300)
cargo_car.number = 100
p cargo_car.info
p "valid: #{cargo_car.valid?}"

p '---------------'
p 'passenger car'
p 'Invalid tests:'
begin
  p '1. Validate seats type'
  PassengerCar.new(:qwe)
rescue TypeError => e
  p "Error: #{e.message}"
end

begin
  p '2. Validate seats presence '
  passenger_car = PassengerCar.new(45)
  passenger_car.instance_eval '@seats = nil', __FILE__, __LINE__
  passenger_car.validate!
rescue ArgumentError => e
  p "Error: #{e.message}"
end

p 'Valid tests:'
passenger_car = PassengerCar.new(45)
passenger_car.number = 100
p passenger_car.info
p "valid: #{passenger_car.valid?}"

p '---------------'
p 'train'
p 'Invalid tests:'
begin
  p '1. Validate number type'
  Train.new(12345)
rescue TypeError => e
  p "Error: #{e.message}"
end

begin
  p '2. Validate number format'
  Train.new('12e5')
rescue RegexpError => e
  p "Error: #{e.message}"
end

begin
  p '3. Validate number presence'
  train = Train.new('12w-21')
  train.route = Route.new(Station.new('first'), Station.new('last'))
  train.instance_eval '@number = nil', __FILE__, __LINE__
  train.validate!
rescue ArgumentError => e
  p "Error: #{e.message}"
end

begin
  p '4. Validate station type'
  train = Train.new('12w-21')
  train.instance_eval '@station = 123', __FILE__, __LINE__
  train.validate!
rescue TypeError => e
  p "Error: #{e.message}"
end

p 'Valid tests:'
p '1. Validation'
train = Train.new('12w-21')
train.route = Route.new(Station.new('first'), Station.new('last'))
p "valid: #{train.valid?}"

p '2. Speed accessor with history'
train.speed = 10
train.speed = 40
train.speed = 60
train.speed = 10
p train.speed_history

p '---------------'
p 'route'
p 'Invalid tests:'
begin
  p 'Validate stations presence'
  route = Route.new(Station.new('first'), Station.new('last'))
  route.instance_eval '@stations = []', __FILE__, __LINE__
  route.validate!
rescue ArgumentError => e
  p "Error: #{e.message}"
end

p 'Valid tests:'
route = Route.new(Station.new('first'), Station.new('last'))
p "valid: #{route.valid?}"

p '---------------'
p 'station'
p 'Invalid tests:'
begin
  p '1. Validate name type'
  Station.new(123)
rescue TypeError => e
  p "Error: #{e.message}"
end

begin
  p '2. Validate name format'
  Station.new('a')
rescue RegexpError => e
  p "Error: #{e.message}"
end

begin
  p '3. Validate name presence'
  station = Station.new('first')
  station.instance_eval '@name = nil', __FILE__, __LINE__
  station.validate!
rescue ArgumentError => e
  p "Error: #{e.message}"
end

p 'Valid tests:'
station = Station.new('name')
p "valid: #{station.valid?}"
