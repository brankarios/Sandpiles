-- Parte 1: Inicializacion y visualizacion de la matriz

fillArray :: Int -> Int -> Int -> Int -> [Int]
fillArray n g i c
  | c == n  = []
  | c == i  = g : fillArray n g i (c + 1)
  | otherwise = 0 : fillArray n g i (c + 1)

initMatrix :: Int -> Int -> (Int, Int) -> [[Int]]
initMatrix n g (x, y) = [fillRow i | i <- [0..n-1]]
  where
    fillRow i
      | i == x    = fillArray n g y 0
      | otherwise = fillArray n 0 y 0


instance {-# OVERLAPPING #-} Show [[Int]] where
    show :: [[Int]] -> String
    show [] = ""
    show (row:rows) = showRow row ++ "\n" ++ show rows
        where
            showRow [] = ""
            showRow [x] = show x
            showRow (x:xs) = show x ++ " " ++ showRow xs

-- Parte 2: Logica de colapso

searchElementInMatrix :: Int -> [[Int]] -> (Int, Int)
searchElementInMatrix _ [] = (-1, -1)
searchElementInMatrix row (x:xs)
  | col /= -1 = (row, col)
  | otherwise = searchElementInMatrix (row + 1) xs
  where
    col = searchElementInArray 0 x

searchElementInArray :: Int -> [Int] -> Int
searchElementInArray _ [] = -1
searchElementInArray i (x:xs)
  | x >= 4    = i
  | otherwise = searchElementInArray (i + 1) xs

modifyNeighbourInMatrix :: (Int, Int) -> Int -> [[Int]] -> [[Int]] -> [[Int]]
modifyNeighbourInMatrix (_, _) _ [] m = []
modifyNeighbourInMatrix (i, j) row (x:xs) m
  | row == i-1 = modifyNeighbourInArray j 0 1 x : modifyNeighbourInMatrix (i,j) (row + 1) xs m
  | row == i = modifyNeighbourInArray (j+1) 0 1 (modifyNeighbourInArray (j-1) 0 1 (modifyNeighbourInArray j 0 (-4) x)) : modifyNeighbourInMatrix (i,j) (row + 1) xs m
  | row == i+1 = modifyNeighbourInArray j 0 1 x : modifyNeighbourInMatrix (i,j) (row + 1) xs m
  | otherwise = x : modifyNeighbourInMatrix (i,j) (row + 1) xs m

modifyNeighbourInArray :: Int -> Int -> Int -> [Int] -> [Int]
modifyNeighbourInArray _ _ _ [] = []
modifyNeighbourInArray nrow i num (x:xs)
  | i == nrow    = (x+num):xs
  | otherwise = x: modifyNeighbourInArray nrow (i + 1) num xs

collapseStep :: [[Int]] -> [[Int]]
collapseStep m = modifyNeighbourInMatrix (searchElementInMatrix 0 m) 0 m m
main :: IO ()
main = do
  
  let matrix = initMatrix 2 8 (0, 0)
  print matrix
  let modifiedMatrix = collapseStep matrix
  print modifiedMatrix


{- Idea para collapse step

1. Recorremos la matriz en busca del primer elemento que tenga 4 o más granos.
2. Almacenamos sus coordenadas (i,j).
3. Conociendo sus coordenadas, recorremos de nuevo la matriz y modificamos las casillas (i-1, j), (i+1, j), (i, j-1), (i, j+1)
4. Retornamos la matriz modificada.

-}