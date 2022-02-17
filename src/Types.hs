-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Types where

-- newtype Params = Params { file :: String } deriving (Show)
-- new
data Params = Params { 
    file :: String,
    mode1 :: Bool,
    mode2 :: Bool,
    i :: Bool 
    } deriving (Show)