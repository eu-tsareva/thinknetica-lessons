print 'Input first side: '
square_a = gets.chomp.to_f**2
square_hypotenuse = square_a

print 'Input second side: '
square_b = gets.chomp.to_f**2
square_hypotenuse = square_b if square_b > square_hypotenuse

print 'Input third side: '
square_c = gets.chomp.to_f**2
square_hypotenuse = square_c if square_c > square_hypotenuse

puts '-----------------------------------'

if square_a == square_b && square_a == square_c && square_b == square_c
  puts 'Triangle is equilateral and isosceles.'
elsif square_a == square_b || square_a == square_c || square_b == square_c
  puts 'Triangle is isosceles.'
end

if square_hypotenuse == square_a + square_b + square_c - square_hypotenuse
  puts 'Triangle is right-angled.'
else
  puts 'Triangle is not right-angled.'
end
