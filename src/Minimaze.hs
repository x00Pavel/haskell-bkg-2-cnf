-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module Minimaze where
import Types (Grammar (Grammar), Rule (left, right), NonTerminal, Rules, isOneNonTerm)


removeSimpleRules :: Grammar -> Grammar
removeSimpleRules (Grammar nt t s rls) = Grammar nt t s rlsNew
    where
        fnc = updateIfSimple rls
        rlsNew = concatMap fnc nt


updateIfSimple :: Rules -> NonTerminal -> Rules
updateIfSimple rls nt
    | null smplRls = notSmplRls
    | otherwise = notSmplRls ++ [] -- map  expandSimple nt rnt rls
    where
        smplRls = findSimpleRules rls nt
        notSmplRls = findNotSimpleRules rls nt

-- expandSimple :: NonTerminal -> NonTerminal -> Rules -> Rules

-- extractRightSideOfSimpleRule :: Rules -> [NonTerminal]
-- extractRightSideOfSimpleRule

findSimpleRules :: Rules -> NonTerminal -> Rules
findSimpleRules rls nt = filter (\r -> (left r == nt) && isOneNonTerm (right r)) rls

findNotSimpleRules :: Rules -> NonTerminal -> Rules
findNotSimpleRules rls nt = filter (\r -> (left r == nt) && not (isOneNonTerm (right r))) rls

-- fnc :: NonTerminal -> Rules -> Rules
-- fnc nt = filter (\r -> left r == nt)
-- fnc lst (Grammar _ _ _ rls) = []
-- langCNF :: Grammar -> Grammar

-- fnc' :: Int -> Int -> [Int]
-- fnc' x y = map hlp [1,2,3]
--     where
--         hlp z = z + x + y
