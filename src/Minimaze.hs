-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Minimaze where
import Types (Grammar (Grammar), Rule (left, right, Rule), NonTerminal, Rules, isOneNonTerm)
-- import Debug.Trace (traceShow)


-- Remove duplicates from the array --
uniq :: Eq a => [a] -> [a]
uniq [] = []
uniq (x:xs) = x : uniq (filter (/=x) xs)


-- Remove simple rules --
removeSimpleRules :: Grammar -> Grammar
removeSimpleRules (Grammar nt t s rls) = Grammar nt t s newRls
    where
        nA' = map (\x -> (x, findNA rls [x] x)) nt
        newRls = concatMap (updateRules rls) nA'


-- Find set NA for given A --
findNA :: Rules -> [NonTerminal] -> NonTerminal -> [NonTerminal]
findNA rls previousNA nt
    | previousNA == currNA = currNA -- compare with previous iteration
    | otherwise = findNA rls currNA nt -- update
    where
        currNA = uniq (previousNA ++ concatMap (findSimpleRules rls) previousNA)


-- Update rules for given A and set NA --
updateRules :: Rules -> (NonTerminal, [NonTerminal]) -> Rules
updateRules rls (nt, nts) = newRls
    where
        nonSimpleA = concatMap (findNotSimpleRules rls) nts
        newRls = [Rule {left=nt, right=x} | x <- map right nonSimpleA]


-- Find not simple rules for given non-terminal in format different from A -> B -- 
findNotSimpleRules :: Rules -> NonTerminal -> Rules
findNotSimpleRules rls nt = filter (\r -> (left r == nt) && not (isOneNonTerm (right r))) rls


-- Find not simple rules for given non-terminal in format A -> B -- 
findSimpleRules :: Rules -> NonTerminal -> [NonTerminal]
findSimpleRules rls nt = [head $ right x | x <- simpleRls]
    where
        simpleRls = filter (\r -> (left r == nt) && isOneNonTerm (right r)) rls