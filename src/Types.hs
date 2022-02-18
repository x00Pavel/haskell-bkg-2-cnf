-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Types where

-- Representation of input parameters
data Params = Params { 
    file :: String,
    mode1 :: Bool,
    mode2 :: Bool,
    i :: Bool 
    } deriving (Show)


data Rule = Rule {
    left :: Char,
    right :: String
} deriving (Show)


data Language = Language {
    nonTerms :: [Char],
    terms :: [Char],
    startNonTerm :: Char,
    rules :: [Rule]
} deriving (Show)