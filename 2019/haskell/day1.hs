import System.IO

input_path = "../input/day1.txt"

main :: IO ()
main = do
    content <- readFile input_path
    input <- return $ map (read::String->Int) (lines content)
    print $ "part1 " ++ show (sum $ map getFuel1 input)
    print $ "part2 " ++ show (sum $ map getFuel2 input)
        

-- part1 fuel
getFuel1 :: Int -> Int
getFuel1 mass = mass `div` 3 - 2

-- part2 fuel
getFuel2 :: Int -> Int
getFuel2 mass = sum $ takeWhile (> 0) (nextFuel (getFuel1 mass))
   where nextFuel f = [f] ++ nextFuel (getFuel1 f)