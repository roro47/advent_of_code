=begin
--- Day 11: Chronal Charge ---
Each fuel cell has a coordinate ranging from 1 to 300 in both the X (horizontal) and Y (vertical) direction. In X,Y notation, the top-left cell is 1,1, and the top-right cell is 300,1.

The interface lets you select any 3x3 square of fuel cells. To increase your chances of getting to your destination, you decide to choose the 3x3 square with the largest total power.

The power level in a given fuel cell can be found through the following process:

Find the fuel cell's rack ID, which is its X coordinate plus 10.
Begin with a power level of the rack ID times the Y coordinate.
Increase the power level by the value of the grid serial number (your puzzle input).
Set the power level to itself multiplied by the rack ID.
Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
Subtract 5 from the power level.
For example, to find the power level of the fuel cell at 3,5 in a grid with serial number 8:

The rack ID is 3 + 10 = 13.
The power level starts at 13 * 5 = 65.
Adding the serial number produces 65 + 8 = 73.
Multiplying by the rack ID produces 73 * 13 = 949.
The hundreds digit of 949 is 9.
Subtracting 5 produces 9 - 5 = 4.
So, the power level of this fuel cell is 4.

Here are some more example power levels:

Fuel cell at  122,79, grid serial number 57: power level -5.
Fuel cell at 217,196, grid serial number 39: power level  0.
Fuel cell at 101,153, grid serial number 71: power level  4.
Your goal is to find the 3x3 square which has the largest total power. The square must be entirely within the 300x300 grid. Identify this square using the X,Y coordinate of its top-left fuel cell. For example:
=end

def power_level(x, y, serial)
  rack_id = x + 10
  p = ((rack_id * y) + serial)* rack_id
  return p.to_s[-3].to_i - 5
end

def gen_map(serial)
  map = Array.new(300) { Array.new(300, 0) }
  for y in 0...300
    for x in 0...300
      map[y][x] = power_level(x, y, serial)
    end
  end
  return map
end

def max_sum_k(a, k)
  max_sum = a[0...k].inject(0, :+)
  curr_sum = max_sum
  left = 0
  right = k - 1
  for i in k...a.length - 1
    curr_sum = curr_sum - a[i-k] + a[i]
    if curr_sum > max_sum
      left = i - k + 1
      right = i
      max_sum = curr_sum
    end
  end
  return [max_sum, left, right]
end

def find_max_k(map, k)
  max_sum = -Float::INFINITY
  left = 0
  right = 0
  top = 0
  bottom = 0

  for column in 0...300-(k-1)
    rows = map.map { |row| row[column...column + k].inject(0, :+) }
    sum, top_, bottom_ = max_sum_k(rows, k)
    if sum > max_sum
      left = column
      right = column + k - 1
      top = top_
      bottom = bottom_ + k - 1
      max_sum = sum
    end
  end
  return left, top, max_sum
end

def part1(serial)
  map = gen_map(serial)
  return find_max_k(map, 3)
end

def part2(serial)
  map = gen_map(serial)
  max_sum = -Float::INFINITY
  x = 0
  y = 0
  size = 1
  for i in 1..300
    puts i
    x_, y_, sum = find_max_k(map, i)
    if sum > max_sum
      x = x_
      y = y_
      max_sum = sum
      k = i
    end
  end
  return x, y, k
end


