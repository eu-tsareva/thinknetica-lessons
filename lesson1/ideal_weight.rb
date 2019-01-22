print 'What is your name? '
name = gets.chomp

print 'What is your height? '
height = gets.chomp.to_i

puts '-----------------------------------'

ideal_weight = height - 110

if ideal_weight >= 0
  puts "Hello, #{name}! Your ideal weight is #{ideal_weight}."
else
  puts "Hello, #{name}! Your weight is already optimal."
end
