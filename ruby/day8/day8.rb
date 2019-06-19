def input
  File::readlines('day8_input.txt')[0].split(' ').map { |s| s.to_i }
end

=begin
def parse_node(sum, curr, numbers)
  if curr < numbers.length
    n_child_nodes = numbers[curr]
    n_meta_entries = numbers[curr+1]
    curr += 2
    while n_child_nodes >= 0
      sum, curr = parse_node(sum, curr, numbers)
      n_child_nodes -= 1
    end

    while n_meta_entries >= 0
      sum += numbers[curr]
      curr += 1
      n_meta_entries -= 1
    end
  end
  
  return sum, curr
end
=end

def part1(numbers)
  stack = []
  stack.push([numbers[0], numbers[1]]) # [ n_child_nodes, n_metadata_entries ]
  curr = 2
  sum = 0
  while (parent = stack.pop) != nil && curr < numbers.length
    if parent[0] == 0
      while parent[1] > 0
        sum += numbers[curr]
        curr += 1
        parent[1] -= 1
      end
    else
      stack.push([parent[0] - 1, parent[1]])
      stack.push([numbers[curr], numbers[curr+1]])
      curr += 2
    end
  end
    
  puts "part1 answer"
  puts "sum : #{sum}"
end

class Node
  attr_reader :child_left, :is_child, :n_meta, :child_val, :is_head
  attr_writer :child_left, :is_child, :n_meta, :child_val, :is_head
  def initialize(n_child, n_meta, is_head)
    @child_left = n_child
    @is_child = n_child == 0
    @n_meta = n_meta
    @child_val = []
    @is_head = is_head
  end
end

def part2(numbers)
  stack = []
 
  stack.push(Node.new(0, 0, true))
  stack.push(Node.new(numbers[0], numbers[1], false))
  curr = 2
  while !(stack.last).is_head
    node = stack.pop
    if node.child_left == 0
      node_sum = 0
      for i in 0..(node.n_meta-1)
        if node.is_child
          node_sum += numbers[curr]
        else
          if numbers[curr]-1 < node.child_val.length
            node_sum += node.child_val[numbers[curr]-1]
          end
        end
        curr += 1
       end
       stack.last.child_val.push(node_sum)
    else
      node.child_left -= 1
      stack.push(node)
      stack.push(Node.new(numbers[curr], numbers[curr+1], false))
      curr += 2
    end
  end
  
  puts "part2 answer"
  puts "sum : #{stack.last.child_val.reduce(:+)}"
end

part1(input)
part2(input)
