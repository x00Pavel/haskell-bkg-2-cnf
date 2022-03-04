-- Projekt: Prevod bezkontextové vlastní gramatiky na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Main where
import System.Environment ( getArgs )
import ParseInput ( argsParse, validateContent )
import Types (Params, file, i, mode1, mode2, showGrammar)
import qualified Control.Monad
import Minimaze (removeSimpleRules, createCNF)


main :: IO ()
main = do
    args <- getArgs
    let param = argsParse args
    let fileName = getFileName param
    cnt <- readFile' fileName
    
    let lang = validateContent cnt
    Control.Monad.when (getIMode param) $ showGrammar lang
    
    let gramNoSimpleRls = removeSimpleRules lang
    Control.Monad.when (get1Mode param) $ showGrammar gramNoSimpleRls

    let langCNF = createCNF gramNoSimpleRls
    Control.Monad.when (get2Mode param) $ showGrammar langCNF


-- Get file name from Params
getFileName :: Params -> String
getFileName = file


-- Get value for -i parameter --
getIMode :: Params -> Bool
getIMode = i


-- Ger flag -1 -- 
get1Mode :: Params -> Bool
get1Mode = mode1


-- Get flag -2 -- 
get2Mode :: Params -> Bool
get2Mode = mode2


-- Read content from STDIN or from the file --
readFile' :: String -> IO String
readFile' x = case x of
    "stdin" -> do getContents
    _       -> do readFile x
