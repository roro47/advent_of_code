WORKER_ID = 1
ASLEEP = 2
WAKEUP = 3

# format each line of info in a chronologically sortable format
class GuardRecord
  attr_reader :year, :month, :day, :hour, :minute, :type, :id
  def initialize(s)
    times = s.match('\[.*\]',).to_s.gsub(/\[|\]/, '').gsub(/:|-/, ' ').split(' ').map { |x| x.to_i }
    @minute = times[4]
    @type = -1
    @id = -1
    if s.match('#') != nil
      @type = WORKER_ID
      @id = s.match('#\d*').to_s.sub('#', '').to_i
    elsif s.match('asleep') != nil
      @type = ASLEEP
    elsif s.match('wakes') != nil
      @type = WAKEUP
    end
  end
end

# get hash table of word id to list of sleeping interval
# an interval is a list of starting time and sleeping time
def process_inputs
   records = File::readlines('day4_p1_input.txt').sort.map { |x| GuardRecord.new(x) }
   id = -1
   i = 0

   time_asleep = Hash.new { |h, k| h[k] = Array.new }
   while i < records.length
     if records[i].type == WORKER_ID
       id = records[i].id
     else
       raise "Guard wakes up before falling asleep"  unless records[i].type == ASLEEP
       time_asleep[id].push([records[i].minute, records[i+1].minute])
       i += 1
     end
     i += 1
   end

   return time_asleep
end

def find_most_asleep (asleep_time)
  ends = []
  max_cut_ends = -1
  max_minute = -1
  for time in asleep_time.sort_by { |a| a[0] }
    t1 = time[0] # start
    t2 = time[1] # end
    while ends.length > 0 && t1 > ends[0]
      ends.shift
    end
    ends = ends.push(t2).sort
    if ends.length > max_cut_ends
      max_cut_ends = ends.length
      max_minute = t1
    end
  end
  return max_minute
end



def part1
  intervals = process_inputs 
  (max_id, max_intervals) = 
    intervals.max_by { |k, v| v.inject(0) { |sum, l| sum + l[1] - l[0] } }
  max_minute = find_most_asleep (max_intervals)
  puts "max_id : #{max_id}"
  puts "max_minute : #{max_minute}"
  return max_id *max_minute
end

def part2
  hash_intervals = process_inputs
  max_minute = -1
  max_count = -1
  max_id = -1
  hash_intervals.each { |id, intervals|
    minute = find_most_asleep (intervals)
    count = 0
    intervals.each { |t|
      if t[0] <= minute && minute <= t[1]
        count += 1
      end
    }

    puts "count : #{count}| with id #{id} and minute #{minute}"
    if count > max_count
      max_id = id
      max_count = max_count
      max_minute = minute
    end
  }
  puts "max_id : #{max_id}"
  puts "max_minute : #{max_minute}"
  return max_id *max_minute
end


puts "part1 answer: #{part1}"
puts "part2 answer: #{part2}"
