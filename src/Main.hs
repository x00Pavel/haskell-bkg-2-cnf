-- Projekt: Prevod bezkontextové vlastní gramatiky na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Main where
import System.Environment ( getArgs )
import ParseInput ( argsParse, validateContent )
import Types (Params (file))

main :: IO ()
main = do
    args <- getArgs
    let param = argsParse args
    let fileName = getFileName param
    cnt <- readFile' fileName
    let valid = validateContent cnt
    print valid


getFileName :: Params -> String
getFileName = file

readFile' :: String -> IO String
readFile' x = case x of
    "stdin" -> do logMsg "Reading from STDIN\n"
                  getContents
    _       -> do logMsg "Reading from file\n"
                  readFile x 

logMsg :: String -> IO ()
logMsg = putStrLn