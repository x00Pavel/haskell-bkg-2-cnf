-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module ParseInput where
import Types (Params (Params), file, mode1, mode2, i)
import Data.Char

-- Parse command line arguments -- 
argsParse :: [String] -> Params
argsParse [] = Params {file="stdin", mode1=False , mode2=False, i=False }
argsParse x = Params {file=f, mode1=m1, mode2=m2, i=i' }
    where
        m1 = "-1" `elem` x
        m2 = "-2" `elem` x
        i' = "-i" `elem` x
        f = findFile x

-- Find file name in all parameteres
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


validateContent :: String -> Bool
validateContent [] = error "Empty string"
validateContent x = validateHeader $ take 3 $ lines x

validateHeader :: [String] -> Bool
validateHeader [x, y, z]
    | isUpper' x && isLower' y && length z == 1 && head z `elem` x = True
    | otherwise = error "Wrong header"
validateHeader _ = error "Wrong header"

isUpper' :: String -> Bool
isUpper' x
    | (h == ',' || h == ' ')  && not (null t) = isUpper' t
    | isUpper h && not (null t) = isUpper' t
    | isUpper h = True
    | otherwise = False
    where
        h = head x
        t = tail x

isLower' :: String -> Bool
isLower' x
    | (h == ',' || h == ' ')  && not (null t) = isLower' t
    | isLower h && not (null t) = isLower' t
    | isLower h = True
    | otherwise = False
    where
        h = head x
        t = tail x