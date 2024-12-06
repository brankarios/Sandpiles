-- César Carios, 30136117 y Jhonatan Homsany, 30182893 --

-- Parte 1: Inicializacion y visualizacion de la matriz

fillArray :: Int -> Int -> Int -> Int -> [Int]
fillArray n g i c
  | c == n  = []
  | c == i  = g : fillArray n g i (c + 1)
  | otherwise = 0 : fillArray n g i (c + 1)

initMatrix :: Int -> Int -> (Int, Int) -> [[Int]]
initMatrix n g (x, y)
  | n <= 0 = error "El tamaño de la matriz no puede ser menor o igual que cero"
  | g < 0 = error "No se puede tener una cantidad negativa de granos de arena"
  | x < 0 || y < 0 = error "No se pueden procesar índices negativos en la matriz"
  | x >= n || y >= n = error "No se pueden introducir coordenadas fuera del alcance del tamaño de la matriz"
  | otherwise = [fillRow i | i <- [0..n-1]]
  where 
    fillRow i 
      | i == x = fillArray n g y 0 
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

searchCoordinates :: Int -> Int -> [[Int]] -> [(Int, Int)]
searchCoordinates _ _ [] = []
searchCoordinates i _ ([]:xs) = searchCoordinates (i + 1) 0 xs
searchCoordinates i j ((y:ys):xs) 
  | y >= 4 = (i, j) : searchCoordinates i (j + 1) (ys:xs)
  | otherwise = searchCoordinates i (j + 1) (ys:xs)

passCoordinates :: [(Int, Int)] -> [[Int]] -> [[Int]]
passCoordinates [] m = m
passCoordinates (x:xs) m = passCoordinates xs (modifyNeighbourInMatrix x 0 m) 

modifyNeighbourInMatrix :: (Int, Int) -> Int -> [[Int]] -> [[Int]]
modifyNeighbourInMatrix (-1, -1) _ _ = []
modifyNeighbourInMatrix _ _ [] = []
modifyNeighbourInMatrix (i, j) row (x:xs)
  | row == i-1 || row == i+1 = modifyNeighbourInArray j 0 1 x : modifyNeighbourInMatrix (i,j) (row + 1) xs
  | row == i = modifyNeighbourInArray (j+1) 0 1 (modifyNeighbourInArray (j-1) 0 1 (modifyNeighbourInArray j 0 (-4) x)) : modifyNeighbourInMatrix (i,j) (row + 1) xs
  | otherwise = x : modifyNeighbourInMatrix (i,j) (row + 1) xs


modifyNeighbourInArray :: Int -> Int -> Int -> [Int] -> [Int]
modifyNeighbourInArray _ _ _ [] = []
modifyNeighbourInArray column start num (x:xs)
  | start == column   = (x+num):xs
  | otherwise = x: modifyNeighbourInArray column (start + 1) num xs

collapseStep :: [[Int]] -> [[Int]]
collapseStep m = do
  passCoordinates (searchCoordinates 0 0 m) m 

-- Parte 3: Simulación Completa -- 

sandpilesSimulate :: [[Int]] -> IO [[Int]] 
sandpilesSimulate matrix = do 
  if searchCoordinates 0 0 matrix == [] 
  then do  
    return []
    else do 
      let newMatrix = collapseStep matrix 
      print newMatrix 
      sandpilesSimulate newMatrix


-- Parte 4: Suma de Sandpiles

sandpilesSum :: [[Int]] -> [[Int]] -> IO [[Int]]
sandpilesSum a b = do
  let c = [[x + y | (x,y) <- zip ai bi] | (ai,bi) <- zip a b]
  print c
  sandpilesSimulate c