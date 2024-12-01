-- César Carios, C.I: 30136117 --
-- Jhonatan Homsany, C.I: 30182893 --

{-

mifun :: [[Int]] -> Int
mifun = foldr op 0
    where op x r = head x + r

main :: IO ()
main = do
    let listas = [[1,2,3] , [2,4,5]]
    let resultado = mifun listas
    putStrLn $ "La suma de los primeros elementos es: " ++ show resultado
    
    -}

-- Parte 1: Inicialización y visualización de la matriz -- 

initMatrix :: Int -> Int -> (Int, Int) -> [[ Int ]]
initMatrix n g (x,y) = [[if i == x && j == y then g else 0 
    | j <- [0..n-1]] 
    | i <- [0..n-1]]

matrixString :: [[Int]] -> String
matrixString = unlines . map(unwords . map show)

printMatrix :: [[Int]] -> IO ()
printMatrix = putStr . matrixString

-- Parte 2: Logica de colapso

collapseStep :: [[ Int ]] -> [[ Int ]]
collapseStep (x:xs) 

main :: IO ()
main = do
    
    let matrix = initMatrix 3 20 (1,1)
    printMatrix matrix