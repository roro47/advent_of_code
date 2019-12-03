class Rec
  attr_reader :x, :y, :width, :height
  def initialize(s)
    @x = get_x(s)
    @y = get_y(s)
    @width = get_width (s)
    @height = get_height (s)
  end
  def get_x(s)
    return s.match(' \d*,').to_s.to_i
  end

  def get_y(s)
    return s.match(',\d*:').to_s.sub(',', '').to_i
  end

  def get_width(s)
    return s.match(' \d*x').to_s.to_i
  end

  def get_height(s)
    return s.match('x\d*').to_s.sub('x', '').to_i
  end
end

len = 1000

fabric = Array.new(len) {Array.new(len) {Array.new()}}
i = 1
File.open('day3_p1_input.txt', 'r') do |f| 
  while line = f.gets
    rec = Rec.new(line)
    x_end = rec.x + rec.width - 1
    y_end = rec.y + rec.height - 1
    for x in rec.x..x_end
      for y in rec.y..y_end 
        fabric[y][x].push(i) 
      end
    end
    i = i + 1
  end
end

h = Hash.new

claim = 0
for i in 0..999
  for j in 0..999
    
    if fabric[j][i].length >= 2
      fabric[j][i].each { |id|
        h[id] = 0 
      }
      claim = claim + 1
    else 
      if !h.has_key?(fabric[j][i][0])
        h[fabric[j][i][0]] = 1
      end
    end
  end
end
puts "claim : #{claim}"

h.each { |key, val|
  if val == 1
    puts "appear once claim: #{key}"
  end
}
