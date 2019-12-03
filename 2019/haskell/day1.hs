import System.IO

input_path = "../input/day1.txt"

main :: IO ()
main = do
    content <- readFile input_path
    let input = map (read::String->Int) (lines content)
        sumFuel = sum $ map getFuel input in
        print sumFuel

getFuel :: Int -> Int
getFuel mass = mass `div` 3 - 2