ids = File::readlines('day2_p2_input.txt').map { |l| l.chomp }

min = 10
i = 0
while i < ids.length
  j = i + 1
  while j < ids.length
    d = 0
    ts = ids[i].chars.zip(ids[j].chars)
    ts.each { |t| d += t[0] == t[1] ? 0 : 1 }
    #puts ids[i]
    #puts ids[j]
    puts "d is #{d}"
#=begin
    if d == 1
      puts "it is 2"
      puts ids[i]
      puts ids[j]
      s = ""
      ts.each { |t| s += t[0] == t[1] ? t[0] : ""}
      puts "#{s}"
      return 
    end
#=end
    if d < min
      min = d
    end
    j += 1
  end
  i += 1
end 
puts "min : #{min}"
puts "ids length : #{ids.length}"
puts "each id length: #{ids[0].length}"


def diff(s1, s2)
  d = 0
  ts = s1.chars.zip(s2.chars)
  ts.each { |t| d += t[0] == t[1] ? 0 : 1 }
  puts "d is #{d}"
end

s1 = "fghij"
s2 = "fguij"
diff(s1, s2)
