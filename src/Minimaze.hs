-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Minimaze where
import Types (Grammar (Grammar), Rule (left, right, Rule), NonTerminal, Rules, isOneNonTerm, Terminal, isTerm, showRules)
import Debug.Trace (traceShow)
import Data.List (partition)

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
findSimpleRules rls nt = [take 1 $ right x | x <- simpleRls]
    where
        simpleRls = filter (\r -> (left r == nt) && isOneNonTerm (right r)) rls


createCNF :: Grammar -> Grammar
createCNF g@(Grammar nts ts st rls) = Grammar nts' ts st rls'
    where
        (moreThen2, lessThen3) = partition (\(Rule _ r) -> length r > 2) rls
        (equal2, equal1) = partition (\(Rule _ r) -> length r == 2) lessThen3
        (onlyNonTerm, rest) = partition (\(Rule _ r) -> isOneNonTerm (take 1 r) && isOneNonTerm (tail r)) equal2
        parts = concatMap (\(Rule l r) -> splitToPart' l r) moreThen2
        tmp_rls = concatMap (\(s, l, r, rest) -> Rule s (l ++ r) : rest) parts
        -- extraxt new rules
        -- s = concatMap snd parts
        -- rs = concatMap (\(_,_,r) -> r) s
        -- no_rules = 
        -- fst_rule = Rule NonTerminal String

        -- tmp_rls = map (\(s, lst) -> Rule s (fst lst!!1 ++ snd lst!!1)) parts
        nts' = nts
        rls' = traceShow parts equal1 ++ onlyNonTerm ++ tmp_rls


splitToPart' :: NonTerminal -> NonTerminal -> [(NonTerminal, NonTerminal, NonTerminal, Rules)]
splitToPart' start [x,y] = [(start, [x],[y], [])]
splitToPart' start (x:xs)
    | isTerm [x] = (start , newTerm, rest, [Rule newTerm [x]]) : splitToPart' rest xs
    | otherwise = (start, [x], rest, []) : splitToPart' rest xs
    where
        newTerm = x : "'"
        rest = "<" ++ xs ++">"
splitToPart' _ _ = []
