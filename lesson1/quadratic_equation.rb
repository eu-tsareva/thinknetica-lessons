print 'input factor a: '
a = gets.chomp.to_i

print 'input factor b: '
b = gets.chomp.to_i

print 'input factor c: '
c = gets.chomp.to_i

puts '-----------------------------------'

discriminant = b ** 2 - 4 * a * c
puts "discriminant = #{discriminant}"

if discriminant > 0
  puts "x1 = #{(-b + Math.sqrt(discriminant)) / (2 * a)}"
  puts "x2 = #{(-b - Math.sqrt(discriminant)) / (2 * a)}"
elsif discriminant == 0
  puts "x = #{-b / (2 * a)}"
else
  puts "discriminant < 0. no roots!"
end