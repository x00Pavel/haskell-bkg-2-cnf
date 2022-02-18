-- Projekt: Prevod bezkontextové vlastní gramatiky na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Main where
import System.Environment ( getArgs )
import ParseInput ( argsParse, validateContent )
import Types (Params, file, i, showLanguage)
import qualified Control.Monad

main :: IO ()
main = do
    args <- getArgs
    let param = argsParse args
    let fileName = getFileName param
    cnt <- readFile' fileName
    let lang = validateContent cnt
    Control.Monad.when (getIMode param) $ showLanguage lang


-- Get file name from Params
getFileName :: Params -> String
getFileName = file

-- Get value for -i parameter --
getIMode :: Params -> Bool
getIMode = i


-- Read content from STDIN or from the file --
readFile' :: String -> IO String
readFile' x = case x of
    "stdin" -> do getContents
    _       -> do readFile x
                  

logMsg :: String -> IO ()
logMsg = putStrLn