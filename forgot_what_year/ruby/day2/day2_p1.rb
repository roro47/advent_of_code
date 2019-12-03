twos = 0
threes = 0
a_ord = 'a'.ord
alpha = Array.new(26, 0)
File::open('day2_p1_input.txt', 'r') do |f|
  while line = f.gets
    line = line.chomp
    line.each_char { |c| alpha[c.ord - a_ord] += 1 }
    if alpha.include?(2)
      twos += 1
    end
    if alpha.include?(3)
      threes += 1
    end
    alpha = alpha.map { |c| 0 }
  end
end

puts twos * threes
    
