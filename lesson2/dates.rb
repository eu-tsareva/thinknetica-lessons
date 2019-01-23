print 'input day: '
day = gets.chomp.to_i

print 'input month: '
month = gets.chomp.to_i

print 'input year: '
year = gets.chomp.to_i

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
leap_year = year % 4 == 0 ? (year % 100 == 0 ? year % 400 == 0 : true) : false
days_in_month[1] = 29 if leap_year

date = day + days_in_month.take(month - 1).reduce(:+)
puts "Your date is the #{date} day of year #{year}."
