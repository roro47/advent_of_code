def process_input
  File::readlines('day7_input.txt').map { |s| 
    [ s.match('Step \K.').to_s, s.match('step \K.').to_s ] 
  }
end

def process_edges(edges)
  edge_in = Hash.new(0)
  edge_out = Hash.new { |h, k| h[k] = [] }
  edges.each { |f, t|
    edge_out[f].push(t)
    if !edge_in.has_key?(f)
      edge_in[f] = 0
    end
    edge_in[t] += 1
  }

  return edge_in, edge_out
end

def next_step(edge_in)
  step = edge_in.select { |h, k| k == 0 }
  return nil if step == {}
  step = step.min_by { |h, k| h }
  edge_in.delete(step[0])
  return step
end

def part1(edges)
  edge_in, edge_out = process_edges(edges)

  result = ""
  while !edge_in.empty?
    step = next_step(edge_in)
    edge_out[step[0]].each { |n| edge_in[n] -= 1 }
    result += step[0]
  end
  puts "part1 answer"
  puts "result: #{result}"
end

def part2(edges)
  edge_in, edge_out = process_edges(edges)
  n_worker = 5
  workers = Array.new(n_worker) { [ "", 0 ] }

  time = 0
  loop do
    i = 1
    print "time: #{time}  "
    workers.each { |worker|
      if worker[0] == "" || worker[1] == 0
        if worker[0] != ""
          edge_out[worker[0]].each { |n| edge_in[n] -= 1 }
        end
        step = next_step(edge_in)
        if step == nil
          worker[0] = ""
          worker[1] = 0
        else
          worker[0] = step[0]
          worker[1] = step[0].ord - 'A'.ord + 60
        end
      else
        worker[1] -= 1
      end
      print "worker #{i} : #{worker[0]} |"
      i += 1
    }
    puts ""
    break if workers.all? { |worker| worker[0] == "" && worker[1] == 0 }
    time += 1
  end
  puts "part2 answer"
  puts "time required : #{time}"
end

part1(process_input)
part2(process_input)
