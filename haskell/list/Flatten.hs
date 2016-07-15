module Main where

flatten :: [[a]] -> [a]
flatten [] = []
flatten ([]:xs) = flatten xs
flatten ((y:ys):xs) = y:(flatten ys:xs)

main :: IO ()
main = do
    -- let l1 = [[1,2,3],[4,5,6],[7,8,9]]
    -- let l2 = flatten l1
    let l2 = [1,2,3]
    putStrLn $ show l2
