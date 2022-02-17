-- Projekt: Prevod bezkontextové vlastní gramatiky na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Main where
import System.Environment ( getArgs )
import ParseInput ( argsParse )
import Types (Params (file))

main :: IO ()
main = do
    args <- getArgs
    let param = argsParse args
    print param
    let fileName = getFileName param
    cnt <- readFile fileName
    putStr cnt

getFileName :: Params -> String
getFileName = file
