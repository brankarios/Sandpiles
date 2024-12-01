-- Parte 1: Inicializacion y visualizacion de la matriz --

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

main :: IO ()
main = do

    let matrix = initMatrix 3 20 (1, 1)
    print matrix
