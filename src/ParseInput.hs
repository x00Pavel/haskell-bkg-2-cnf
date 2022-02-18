-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module ParseInput where
import Types (Params (Params), file, mode1, mode2, i,
              Language (Language), terms, nonTerms, startNonTerm, rules,
              Rule (Rule))
import Data.Char ( isLower, isUpper )
import Data.List ( stripPrefix )
import Data.Maybe ( fromMaybe)


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
validateContent :: String -> Language
validateContent [] = error "Empty string"
validateContent x = Language {nonTerms=nt, terms=t, startNonTerm=s, rules=rls}
    where
        (header, rs) = splitAt 3 $ lines x
        (nt, t, s) = validateHeader header
        rls = validateRules rs nt t


-- Validates header (first 3 lines) of the file --
validateHeader :: [String] -> ([Char], [Char], Char)
validateHeader [x, y, z]
    | isUpper' x && isLower' y && length z == 1 && s `elem` x = (nt, t, s)
    | otherwise = error "Wrong header"
    where
        nt =  filter (`elem` ['A'..'Z']) x
        t = filter (`elem` ['a'..'z']) y
        s = head z
validateHeader _ = error "Wrong header"


-- Validates rules format A -> subset of terminals and non-terminals -- 
validateRules :: [String] -> String -> String -> [Rule]
validateRules xs n t = map (\ x -> validateR x n t) xs

-- Parse individual rule base of form A -> X where each char in X is in NT ++ Sigma --
validateR :: String -> String -> String -> Rule
validateR r n t
    | (head r' `elem` n) && checkSubstr l (n ++ t) = Rule h l
    | otherwise = error ("Wrong rule: " ++ show r')
    where
        r' = filter (/= ' ') r
        h = head r'
        l = stripPrefix' (h : "->") r'


-- Checks if each character from the string is an element of the given list
checkSubstr :: String -> [Char] ->Bool
checkSubstr substr lst = all ((== True ) . (`elem` lst)) substr || error ("String " ++ substr ++ " is not subset of " ++ lst)


-- Get left side of the rule. Prefix has to be 'A->' --
stripPrefix' :: String  -> String -> String
stripPrefix' x y = fromMaybe (error ("Wrong prefix of the rule: " ++ y ++ "\n" ++ x ++ " not in " ++ y)) a
    where
        a = stripPrefix x y


-- Custom function isUpper that skips commas and spaces --
isUpper' :: String -> Bool
isUpper' x
    | (h == ',' || h == ' ')  && not (null t) = isUpper' t
    | isUpper h && not (null t) = isUpper' t
    | isUpper h = True
    | otherwise = False
    where
        h = head x
        t = tail x


-- Custom function isLower that skips commas and spaces --
isLower' :: String -> Bool
isLower' x
    | (h == ',' || h == ' ')  && not (null t) = isLower' t
    | isLower h && not (null t) = isLower' t
    | isLower h = True
    | otherwise = False
    where
        h = head x
        t = tail x
