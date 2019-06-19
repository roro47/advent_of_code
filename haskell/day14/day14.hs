import Control.Monad.State

puzzleInput :: Int
puzzleInput = [1, 0, 6, 9, 3, 9]


-- recipes, elf1 pos, elf2 pos
data RecipeState = RecipeState { recipes :: [Int],
                                 elf1 :: Int,
                                 elf2 :: Int } deriving (Eq)


cooking :: State RecipeState [Int]
cooking = 

main = print $ evalState cooking 
  where startRecipes = [7, 3]
        startState = RecipeState startRecipes 1 0

