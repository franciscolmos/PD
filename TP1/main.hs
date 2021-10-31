
import System.IO (openFile, hGetContents, IOMode (ReadMode), hClose)
import Data.List (isPrefixOf, zip4)
import DataHora

main = do
    archivo <- openFile "09septiembre2019.txt" ReadMode
    contenido  <- hGetContents archivo
    let lineas = lines contenido

        registros = filter filtrarRenglones lineas

        registrosIncompletos = map words registros
        matrizIngresosEgresos = map (map (filter (`notElem` "\"\""))) registrosIncompletos

        tuplas = map hacerTuplas matrizIngresosEgresos

        

    print tuplas
    hClose archivo


{- Toma el texto y le quito los renglones que no tienen dias -}
filtrarRenglones :: String -> Bool
filtrarRenglones str | str == "\r" = False
                     | otherwise = (!! 0) (words str) `elem` ["\"Lunes\"", "\"Martes\"", "\"Miercoles\"", "\"Jueves\"", "\"Viernes\""]

hacerTuplas :: [String] -> [(String, String)]
hacerTuplas [] = []
hacerTuplas str = ((!!0) str, (!!1) str) : hacerTuplas (tail (tail str))


-- , "\"Total"