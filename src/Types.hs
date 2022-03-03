-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Types where
import Data.List (intersperse, intercalate)

data NonTerm = NonTerm String | SingleNonTerm Char
type NonTerminal = String
type Terminal = Char
type Rules = [Rule]

-- Representation of input parameters --
data Params = Params {
    file :: String,
    mode1 :: Bool,
    mode2 :: Bool,
    i :: Bool
    } deriving (Show)


-- Representation of the rule
data Rule = Rule {
    left :: NonTerminal,
    right :: String
} deriving (Show,  Eq, Ord)


-- Representation of the language --
data Grammar = Grammar {
    nonTerms :: [NonTerminal],
    terms :: [Terminal],
    startNonTerm :: NonTerminal,
    rules :: Rules
} deriving (Show)


-- Represents whole language if '-i' is specified -- 
showGrammar :: Grammar -> IO ()
showGrammar (Grammar nt t s r) = do
    let ntS = intercalate "," nt ++ "\n"
    let tS = intersperse ',' t ++ "\n"
    let sS = s ++ "\n"
    let rlS = showRules r
    putStrLn (ntS ++ tS ++ sS ++ rlS)

-- Transofrms list of rules to one string for printing out --
showRules :: [Rule] -> String
showRules x = intercalate "\n" (map (\(Rule l r) -> l ++ "->" ++ r ) x)

-- Check if given string contains only one non-teminal -- 
isOneNonTerm :: String -> Bool
isOneNonTerm [] = False
isOneNonTerm (x:xs) = x `elem` ['A'..'Z'] && null xs

charToNonTerminal :: Char -> NonTerminal
charToNonTerminal c = [c]