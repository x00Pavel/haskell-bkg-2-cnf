-- Projekt: Prevod bezkontextové vlastní gramatiky (dále BKG) na bezkontextové gramatiky v Chomského normální formě
-- Nazev: BKG-2-CNF
-- Autor: Pavel Yadlouski (xyadlo00)
-- Rok: 2021/2022

module ParseInput where
import Types (Params (Params), file, mode1, mode2, i)


argsParse :: [String] -> Params
argsParse [] = error "No parameters are pecified."
argsParse [x] = Params x False False False
argsParse [x, y]
    | y == "-i" = Params {file=x, mode1=False, mode2=False, i=True }
    | y == "-1" = Params {file=x, mode1=True, mode2=False, i=False }
    | y == "-2" = Params {file=x, mode1=False, mode2=True, i=False }
    | otherwise = Params {file=x, mode1=False, mode2=False, i=False}
argsParse [x,y,z]
    | y == z = error "Some argumetns are the some"
    | (y == "-i" || z == "-i") && (y == "-1" || z == "-1") && (y /= z) = Params x True False True
    | (y == "-i" || z == "-i") && (y == "-2" || z == "-2") && (y /= z) = Params x False True True
    | (y == "-1" || z == "-1") && (y == "-2" || z == "-2") && (y /= z) = Params x True True False 
    | otherwise = Params x False False False 

argsParse [x,y,z,j]
    | (y == z) || (z == j) || (y == j) = error "Some argumetns are the some" 
    | (y == "-i" || z == "-i" || j == "-i") && 
      (y == "-1" || z == "-1" || j == "-1") && 
      (y == "-2" || z == "-2" || j == "-2") = Params x True True  True
    | otherwise = Params x False False False

argsParse (x:y:z:j:_) = error "Too much parameters"
