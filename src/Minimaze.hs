-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Minimaze where
import Types (Grammar (Grammar), Rule (left, right, Rule), NonTerminal, Rules, isOneNonTerm)
-- import Debug.Trace (traceShow)


uniq :: Eq a => [a] -> [a]
uniq [] = []
uniq (x:xs) = x : uniq (filter (/=x) xs)


removeSimpleRules :: Grammar -> Grammar
removeSimpleRules (Grammar nt t s rls) = Grammar nt t s newRls
    where
        nA' = map (\x -> (x, findNA rls [x] x)) nt
        newRls = concatMap (updateRules rls) nA'

findNA :: Rules -> [NonTerminal] -> NonTerminal -> [NonTerminal]
findNA rls previousNA nt
    | previousNA == currNA = currNA
    | otherwise = findNA rls currNA nt
    where
        currNA = uniq (previousNA ++ concatMap (findSimpleRules rls) previousNA)


updateRules :: Rules -> (NonTerminal, [NonTerminal]) -> Rules
updateRules rls (nt, nts) = newRls
    where
        nonSimpleA = concatMap (findNotSimpleRules rls) nts
        newRls = [Rule {left=nt, right=x} | x <- map right nonSimpleA]


findNotSimpleRules :: Rules -> NonTerminal -> Rules
findNotSimpleRules rls nt = filter (\r -> (left r == nt) && not (isOneNonTerm (right r))) rls


findSimpleRules :: Rules -> NonTerminal -> [NonTerminal]
findSimpleRules rls nt = [head $ right x | x <- simpleRls]
    where
        simpleRls = filter (\r -> (left r == nt) && isOneNonTerm (right r)) rls




-- fnc :: NonTerminal -> Rules -> Rules
-- fnc nt = filter (\r -> left r == nt)
-- fnc lst (Grammar _ _ _ rls) = []
-- langCNF :: Grammar -> Grammar

-- fnc' :: Int -> Int -> [Int]
-- fnc' x y = map hlp [1,2,3]
--     where
--         hlp z = z + x + y
