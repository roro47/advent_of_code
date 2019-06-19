repeat = Hash.new(0)
lines = File::readlines('day2_input.txt').map { |x| x.to_i }
#lines = [3, 3, 4, -2, -4]
#lines = [-6, 3, 8, 5, -6] 
#lines = [7, 7, -2, -7, -4]
i = 0
sum = 0
while true
  sum += lines[i]
  puts lines[i]
  if repeat[sum] == 1
    puts sum
    break
  else
    repeat[sum] = 1
  end
  i = (i + 1) % lines.length
end

puts '\n'.to_i
