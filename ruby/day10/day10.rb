def input
  File::readlines('day10_input.txt').map { |s|
    [ s.match('position=<\K[\-\d ,]*').to_s.sub(',', '').split(' ').map {|s| s.to_i},
      s.match('velocity=<\K[\-\d ,]*').to_s.sub(',', '').split(' ').map {|s| s.to_i} ] }
end

def get_boundary(points)
  return [ points.max_by { |p, v| p[0] }[0][0], 
           points.max_by { |p, v| p[1] }[0][1],
           points.min_by { |p, v| p[0] }[0][0],
           points.min_by { |p, v| p[1] }[0][1] ]
end

def draw(points, max_x, max_y, min_x, min_y)
  max_x = [max_x.abs, min_x.abs].max + 1
  max_y = [max_y.abs, min_y.abs].max + 1
  graph = Array.new(max_y*2) {  Array.new(max_x*2, '.') }

  points.each { |p, v| 
    x = p[0] > 0 ? p[0] + max_x : max_x - p[0].abs
    y = p[1] > 0 ? p[1] + max_y : max_y - p[1].abs
    puts "max_x : #{max_x}, max_y :#{max_y}"
    puts "x: #{x}, y: #{y}"
    graph[y][x] = '#'
  }

  graph.each { |r|
    r.each { |c| print c }
    print "\n"
  }
end

def is_boundary_expanded(points1, points2)
  return (points1[0] - points1[2]) < (points2[0] - points2[2]) ||
         (points1[1] - points1[3]) < (points2[1] - points2[3])
end

def part1(points)
  boundary = get_boundary(points)
  max_x, max_y, min_x, min_y = boundary
    #draw(points, boundary[0], boundary[1], boundary[2], boundary[3]) 
  prev_points = []
  loop do
    puts "max_x : #{boundary[0]}, max_y: #{boundary[1]}, min_x: #{boundary[2]}, min_y: #{boundary[3]}"
    prev_points = Marshal.load(Marshal.dump(points))
    points.each { |p, v|
      p[0] += v[0]
      p[1] += v[1]
    }
    new_boundary = get_boundary(points)
    break if is_boundary_expanded(boundary, new_boundary)
    boundary = new_boundary
    #draw(points, boundary[0], boundary[1], boundary[2], boundary[3]) 
  end
  puts "finish loop"

  boundary = get_boundary(prev_points)
  draw(prev_points,boundary[0], boundary[1], boundary[2], boundary[3])
end

part1(input)
