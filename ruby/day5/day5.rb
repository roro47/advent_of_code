def process_input
  File::readlines('day5_input.txt')[0]
end

def destroy (a, b)
  a.upcase == b.upcase && a.ord != b.ord
end


def react(polymer)
  i = 0
  while i + 1 < polymer.length
    if destroy(polymer[i], polymer[i+1])
      polymer.slice!(i, 2)
      if i - 1 >= 0 && i < polymer.length && destroy(polymer[i-1], polymer[i])
        i = i - 1
      end
    else
      i = i + 1
    end
  end
  return polymer.strip
end

def part1(polymer)
  puts "part1 answer"
  puts "unit left is #{react(polymer).length}"
end

def part2(polymer)
  min_length = polymer.length
  for type in 'a'..'z'
    copy = polymer.dup
    copy.delete!(type)
    copy.delete!(type.upcase)
    copy = react(copy)
    min_length = copy.length < min_length ? copy.length : min_length
  end
  puts "min units left is #{min_length}"
end

polymer = process_input
#polymer = 'dabAcCaCBAcCcaDA'
part1(polymer)
polymer = process_input
#polymer = 'dabAcCaCBAcCcaDA'
part2(polymer)
