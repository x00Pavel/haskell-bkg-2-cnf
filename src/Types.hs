-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Types where
import Data.List (intersperse, intercalate)


-- Representation of input parameters --
data Params = Params {
    file :: String,
    mode1 :: Bool,
    mode2 :: Bool,
    i :: Bool
    } deriving (Show)


-- Representation of the rule
data Rule = Rule {
    left :: Char,
    right :: String
} deriving (Show)


-- Representation of the language --
data Language = Language {
    nonTerms :: [Char],
    terms :: [Char],
    startNonTerm :: Char,
    rules :: [Rule]
} deriving (Show)


-- Represents whole language if '-i' is specified -- 
showLanguage :: Language -> IO () 
showLanguage (Language nt t s r) = do
    let ntS = "Non-terminals: " ++ intersperse ',' nt ++ "\n"
    let tS = "Terminals: " ++ intersperse ',' t ++ "\n"
    let sS = "Start non-terminal: " ++ [s] ++ "\n"
    let rlS = "Rules:\n\t" ++ showRules r
    -- let rlS = "Rules:\n" ++ intersperse '\n' (showRules r)
    putStrLn (ntS ++ tS ++ sS ++ rlS)

-- Transofrms list of rules to one string for printing out --
showRules :: [Rule] -> String
showRules x = intercalate "\n\t" (map show x)
