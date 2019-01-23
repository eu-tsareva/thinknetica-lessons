arr = [0, 1]
while (next_val = arr[-1] + arr[-2]) < 100
   arr << next_val
end
puts "Array with Fibonacci numbers < 100: #{arr}"
