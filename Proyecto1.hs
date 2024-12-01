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

--modifyNeighbourInMatrix :: (Int, Int) -> Int -> [[Int]] -> [[Int]]
--modifyNeighbourInMatrix (i, j) row a = 

modifyNeighbourInArray :: Int-> Int -> [Int] -> [Int]
modifyNeighbourInArray _ _ [] = []
modifyNeighbourInArray nrow i (x:xs)
  | i == nrow    = (x+1):xs
  | otherwise = x: modifyNeighbourInArray nrow (i + 1) xs

main :: IO ()
main = do

    let matrix = initMatrix 3 20 (1, 1)
    let array = [1, 2, 3, 4, 5] 
    let modifiedArray = modifyNeighbourInArray 2 0 array 
    print modifiedArray


{- Idea para collapse step

1. Recorremos la matriz en busca del primer elemento que tenga 4 o más granos.
2. Almacenamos sus coordenadas (i,j).
3. Conociendo sus coordenadas, recorremos de nuevo la matriz y modificamos las casillas (i-1, j), (i+1, j), (i, j-1), (i, j+1)
4. Retornamos la matriz modificada.

-}