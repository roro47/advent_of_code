import System.IO
import Data.List.Split
import Control.Lens

input_path = "../input/day2.txt"

main :: IO ()
main = do
    content <- readFile input_path
    input <- return $ map (read::String -> Int) $ splitOn "," content
    let input1 = newCode input 12 2 in
      print $ "part1: " ++ show ((runIntcode input1 0) !! 0)
    let target = 19690720
        (n, v) = head $ [(noun, verb)| noun <- [0..99]
                                      , verb <- [0..99]
                                      , head (runIntcode (newCode input noun verb) 0) == target
                                    ] in
        print $ "part2: " ++ show (100 * n + v) -- takes around 10 second to execute
  where newCode cs noun verb = (element 1 .~ noun) $ (element 2 .~ verb) cs

runIntcode :: [Int] -> Int -> [Int]
runIntcode cs idx
  | idx >= length cs = cs
  | otherwise = 
      let op = cs !! idx
          inp1 = cs !! (idx + 1)
          inp2 = cs !! (idx + 2)
          outp = cs !! (idx + 3)
      in
        case op of
          1 -> runIntcode ((element outp .~ ((cs !! inp1) + (cs !! inp2))) cs) (idx + 4)
          2 -> runIntcode ((element outp .~ ((cs !! inp1) * (cs !! inp2))) cs) (idx + 4)
          99 -> cs

test1 :: [Int]
test1 = [1,9,10,3,2,3,11,0,99,30,40,50]

test2 :: [Int]
test2 = [1,0,0,0,99]

test3 :: [Int]
test3 = [2,3,0,3,99]