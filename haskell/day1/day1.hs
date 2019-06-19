import System.IO
import Data.HashMap.Strict (HashMap, empty, insert, member)

main = do
  s <- readFile "day1_input.txt"
  let input = map (\x -> if head x == '+' then (read (tail x)::Integer) else read x::Integer) (lines s)
  putStr ("part1 answer: " ++ (show $ part1 input) ++ "\n")
  putStr ("part2 answer: " ++ (show $ part2 input) ++ "\n")

part1 :: [Integer] -> Integer
part1 = sum

part2 :: [Integer] -> Integer
part2 xs = part2' (concat $ repeat xs) 0 empty
  where part2' (x:xs) c h
          | member (c+x) h = (c+x)
          | otherwise = part2' xs (c+x) (insert (c+x) 1 h)
