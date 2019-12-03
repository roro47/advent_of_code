#                1         2         3     
#       0         0         0         0     
# 0: ...#..#.#..##......###...###...........
# 1: ...#...#....#.....#..#..#..#...........
# 2: ...##..##...##....#..#..#..##..........
# 3: ..#.#...#..#.#....#..#..#...#..........
# 4: ...#.#..#...#.#...#..#..##..##.........
# 5: ....#...##...#.#..#..#...#...#.........
# 6: ....##.#.#....#...#..##..##..##........
# 7: ...#..###.#...##..#...#...#...#........
# 8: ...#....##.#.#.#..##..##..##..##.......
# 9: ...##..#..#####....#...#...#...#.......
#10: ..#.#..#...#.##....##..##..##..##......
#11: ...#...##...#.#...#.#...#...#...#......
#12: ...##.#.#....#.#...#.#..##..##..##.....
#13: ..#..###.#....#.#...#....#...#...#.....
#14: ..#....##.#....#.#..##...##..##..##....
#15: ..##..#..#.#....#....#..#.#...#...#....
#16: .#.#..#...#.#...##...#...#.#..##..##...
#17: ..#...##...#.#.#.#...##...#....#...#...
#18: ..##.#.#....#####.#.#.#...##...##..##..
#19: .#..###.#..#.#.#######.#.#.#..#.#...#..
#20: .#....##....#####...#######....#.#..##.






def input
  lines = File.new('day12_input.txt').readlines()
  initial_state = lines[0].match('initial state:\s*([^\n]*)')[1]
                    .chars
                    .each_with_index
                    .map { |x, i| [i, x] }
  rules = lines[2...lines.length].map { |item|
    item.strip.split(" => ")
  }
  return initial_state, rules
end


def get_pot(state, index)
  min_index = state[0][0]
  max_index = state[-1][0]
  if index < min_index || index > max_index
    return [index, '.']
  else
    return state.find { |i, p| i == index }
  end
end

def one_generation(state, rules)
  new_state = []
  min_index = state[0][0]
  max_index = state[-1][0]
  prev = ((min_index-5)..(min_index-1))
           .map { |index| [index, '.'] }
  last = ((max_index+1)..(max_index+5)).map { |index| [index, '.'] }
  state =  prev + state + last
  for i in 0...state.length
    index, pot = state[i]
    nearby = ""
    for j in index-2..index+2
      p = get_pot(state, j)[1]
      nearby = nearby + p
    end

    new_pot = rules.find { |note, result| note == nearby }
    if new_pot == nil
      new_pot = '.'
    else
      new_pot = new_pot[1]
    end
    new_state.push([index, new_pot])
  end

  # remove . in the front and . in the tail
  while new_state[0][1] == '.'
    new_state.shift
  end

  while new_state[-1][1] == '.'
    new_state.pop
  end
  return new_state
end

def part1
  state, rules = input
  for i in 0...50000000000
    puts i
    state = one_generation(state, rules)
  end

  final = state.map { |index, pot| pot}.join('')
  puts "final : #{final}"

  return state.reduce(0) { |sum, item|
    if item[1] == '#'
      sum = sum + item[0]
    else
      sum
    end
  }
end

