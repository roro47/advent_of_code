def process_input
  File::readlines('day6_input.txt').map { |s| 
    s.split(", ").map { |c| c.to_i }
  }
end

def part1(coords)
  max = 10000000000000
  dot = -1
  min_x = coords.min_by { |c| c[0] }[0]
  min_y = coords.min_by { |c| c[1] }[1]
  max_x = coords.max_by { |c| c[0] }[0]
  max_y = coords.max_by { |c| c[1] }[1]
  puts "min_x : #{min_x}, min_y : #{min_y}, max_x: #{max_x}, max_y : #{max_y}"
  exclude_x = [min_x, max_x]
  exclude_y = [min_y, max_y]
  grid = Array.new(max_y+1) { Array.new(max_x+1) { Array.new(2, max) } }

  for i in 0..(coords.length-1)
    x = coords[i][0]
    y = coords[i][1]

    for y2 in min_y..max_y
      for x2 in min_x..max_x
        d = (y2 - y).abs + (x2 - x).abs
        if d < grid[y2][x2][0]
          grid[y2][x2][0] = d
          grid[y2][x2][1] = i
        elsif d == grid[y2][x2][0]
          grid[y2][x2][1] = dot
        end
      end
    end
  end

  area = Hash.new(0)
  infinite = Hash.new(0)

  for x in min_x..max_x
    infinite[grid[max_y][x][1]] = 1
    infinite[grid[min_y][x][1]] = 1
  end
  for y in min_y..max_y
    infinite[grid[y][max_x][1]] = 1
    infinite[grid[y][min_x][1]] = 1
  end
  
  for y in min_y..max_y
    for x in min_x..max_x
      id = grid[y][x][1]
      if id != dot && infinite[id] != 1
        area[id] += 1
      end
    end
  end

  h = area.max_by { |id, a| a }
  max_id, max_area = h[0], h[1]
  puts "max_id : #{max_id}"
  puts "max_area : #{max_area}"
end

def part2(coords)
  min_x = coords.min_by { |c| c[0] }[0]
  min_y = coords.min_by { |c| c[1] }[1]
  max_x = coords.max_by { |c| c[0] }[0]
  max_y = coords.max_by { |c| c[1] }[1]

  grid = Array.new(max_y+1+1000) { Array.new(max_x+1+1000, 0) }
  max_y = max_y + 1000
  max_x = max_x + 1000
  
  size = 0
  for y in 0..max_y 
    for x in 0..max_x
      for coord in coords
        d = (coord[0] - x).abs + (coord[1] - y).abs
        grid[y][x] += d
      end
      if grid[y][x] < 10000
        size += 1
      end
    end
  end
  puts "part2 answer"
  puts "size: #{size}"
end

#part1(process_input)
part2(process_input)
