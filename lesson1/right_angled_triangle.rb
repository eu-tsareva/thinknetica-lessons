print 'Input first side: '
square_a = gets.chomp.to_i ** 2

print 'Input second side: '
square_b = gets.chomp.to_i ** 2

print 'Input third side: '
square_c = gets.chomp.to_i ** 2

puts '-----------------------------------'

if square_a == square_b && square_a == square_c && square_b == square_c
  puts 'Triangle is equilateral and isosceles.'
elsif square_a == square_b || square_a == square_c || square_b == square_c
  puts 'Triangle is isosceles.'
end

if (square_a > square_b) && (square_a > square_c)
  right_angled = (square_a == square_b + square_c)
elsif (square_b > square_a) && (square_b > square_c)
  right_angled = (square_b == square_a + square_c)
elsif (square_c > square_a) && (square_c > square_b)
  right_angled = (square_c == square_b + square_a)
else
  right_angled = false
end

if right_angled
  puts 'Triangle is right-angled.'
else
  puts 'Triangle is not right-angled.'
end