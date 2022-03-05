-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module ParseInput where
import Types (Params (Params), file, mode1, mode2, i,
              Grammar (Grammar), terms, nonTerms, startNonTerm, rules,
              Rule (Rule), NonTerminal, Terminal)
import Data.Char ( isLower, isUpper )
import Data.List ( stripPrefix )
import Data.Maybe ( fromMaybe)
-- import Debug.Trace (traceShow, traceShowId)


-- Parse command line arguments -- 
argsParse :: [String] -> Params
argsParse [] = Params {file="stdin", mode1=False , mode2=False, i=False }
argsParse x = Params {file=f, mode1=m1, mode2=m2, i=i' }
    where
        m1 = "-1" `elem` x
        m2 = "-2" `elem` x
        i' = "-i" `elem` x
        f = findFile x


-- Find file name in all parameters
findFile ::  [String] -> String
findFile [] = "stdin"
findFile x = case head x of
        "-i" -> findFile (tail x)
        "-1" -> findFile (tail x)
        "-2" -> findFile (tail x)
        [] -> "stdin"
        _ -> checkName (head x)


-- Check potential filename --
checkName :: String  -> String
checkName [] = error "Empty name"
checkName x
    | head x == '-' = error "Not valid name"
    | otherwise = x


-- Validates input content -- 
validateContent :: String -> Grammar
validateContent [] = error "Empty string"
validateContent x = Grammar {nonTerms=nt, terms=t, startNonTerm=s, rules=rls}
    where
        (header, rs) = splitAt 3 $ lines x
        (nt, t, s) = validateHeader header
        rls = validateRules rs nt t


-- Validates header (first 3 lines) of the file --
validateHeader :: [String] -> ([NonTerminal], [Terminal], NonTerminal )
validateHeader [x, y, z]
    -- functions isUpeer' / isLower' insures that string contains only leeters,
    -- coma or space. If string whould contain anything else, than program
    -- would end with an error in those functions
    | isUpper' x && isLower' y && length z == 1 && s `elem` x = (nt, t, [s])
    | otherwise = error "Wrong header"
    where
        nt = map charToStr (filter (`elem` ['A'..'Z']) x)
        t = filter (`elem` ['a'..'z']) y
        s = head z
validateHeader _ = error "Wrong header format"


-- Convert one char to string --
charToStr :: Char -> String
charToStr c = [c]


-- Validates rules format A -> subset of terminals and non-terminals -- 
validateRules :: [String] -> [NonTerminal] -> [Terminal] -> [Rule]
validateRules xs ns ts = [validateOneRule x ns ts | x <- xs]


-- Parse individual rule base on form A -> X where each char in X is in NT ++ Sigma --
validateOneRule :: String -> [String] -> [Terminal] -> Rule
validateOneRule r ns ts
    | (leftSide `elem` ns) && checkSubstr rightSide ns ts  = Rule leftSide rightSide
    | otherwise = error ("Wrong rule: " ++ show r')
    where
        r' = filter (/= ' ') r -- remove spaces from the rule
        leftSide = take 1 r'
        rightSide =  stripPrefix' (leftSide ++ "->") r'


-- Checks if each character from the string is an element of the given list
checkSubstr :: String -> [NonTerminal] -> [Terminal] -> Bool
checkSubstr substr ns ts = all (== True )  [[x] `elem` ns || x `elem` ts | x <- substr] || error msg
     where
         msg = "String " ++ substr ++ " is not subset of non terminal and tetminals"


-- Get left side of the rule. Prefix has to be 'A->' --
stripPrefix' :: String -> String -> String
stripPrefix' x y = fromMaybe (error ("Wrong prefix of the rule: " ++ y ++ "\n" ++ x ++ " not in " ++ y)) a
    where
        a = stripPrefix x y


-- Custom function isUpper that skips commas and spaces --
isUpper' :: String -> Bool
isUpper' x
    | (h == ',' || h == ' ')  && not (null t) = isUpper' t -- if current char is comma or space and tail is not empty -> continue with tail
    | isUpper h && not (null t) = isUpper' t
    | isUpper h = True
    | otherwise = False
    where
        h = head x
        t = tail x


-- Custom function isLower that skips commas and spaces --
isLower' :: String -> Bool
isLower' x
    | (h == ',' || h == ' ')  && not (null t) = isLower' t -- if current char is comma or space and tail is not empty -> continue with tail
    | isLower h && not (null t) = isLower' t 
    | isLower h = True
    | otherwise = False
    where
        h = head x
        t = tail x
