puts "Enter your items (print 'stop' to exit)\n\n"

items = {}

loop do
  print 'product: '
  product = gets.chomp
  break if product == 'stop'

  print 'price: '
  price = gets.chomp.to_f

  print 'quantity: '
  quantity = gets.chomp.to_f

  items[product] = { price: price, quantity: quantity }
  puts '--------------------------------'
end

puts "\nYour cart:"
total_price = 0
items.each do |product, details|
  price = details[:price]
  quantity = details[:quantity]
  sum = price * quantity
  puts "#{product}: #{quantity}(items) for #{price} each. Total: #{sum}"
  total_price += sum
end

puts '--------------------------------'
puts "Total price: #{total_price}"

