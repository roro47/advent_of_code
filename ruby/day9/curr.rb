#n_players = 424
#last_marble = 71144
n_players = 30
last_marble = 5807

def part1(n_players, last_marble)
  marbles = []
  score = Hash.new(0)
  curr_player = 0
  placed_marble = 0
  curr_marble = 0
  while placed_marble <= last_marble
    puts "place marble #{placed_marble}"

    if placed_marble == 0 || placed_marble % 23 != 0
      placed_index = marbles.length == 0 ? 
        0 : (curr_marble + 2) % marbles.length
      marbles.insert(placed_index, placed_marble)
      curr_marble = placed_index
    else
      score[curr_player] += placed_marble
      removed_index = (curr_marble - 7 + marbles.length) % marbles.length
      score[curr_player] += marbles[removed_index]
      marbles.delete_at(removed_index)
      curr_marble = removed_index % marbles.length
    end

    placed_marble += 1
    curr_player = (curr_player + 1) % n_players
  end
  puts "part1 answer"
  puts "highest score: #{score.max_by { |h, k| k }[1]}"
end
=begin
[[9, 25], [10, 1618], [13, 7999],
 [17, 1104], [21, 6111], [30, 5807], [424, 71144]].each { 
  |n_players, last_marble| 
  puts "#{n_players} players; last marble #{last_marble}"
  part1(n_players, last_marble) }
=end
part1(424, 71144)
part1(424, 7114400)
