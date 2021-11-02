
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

        diaFecha = map (unirStrings . take 1) tuplas
        horarios = map (tomarTuplas . drop 1) tuplas

        horasSumadas = map (map sumarHoras) horarios

        -- Para los puntos 3, 4 y 5
        horasAcumuladas = map acumularHoras horasSumadas

        horasNormalizadas = map normalizar horasAcumuladas
        stringHoras = map show horasNormalizadas

        resultado = zip diaFecha stringHoras

        test = map mostrarResultado resultado

    --print test
    putStrLn $ unlines test
    hClose archivo


{- Toma el texto y le quito los renglones que no tienen dias -}
filtrarRenglones :: String -> Bool
filtrarRenglones str | str == "\r" = False
                     | otherwise = (!! 0) (words str) `elem` ["\"Lunes\"", "\"Martes\"", "\"Miercoles\"", "\"Jueves\"", "\"Viernes\""]

hacerTuplas :: [String] -> [(String, String)]
hacerTuplas [] = []
hacerTuplas str = ((!!0) str, (!!1) str) : hacerTuplas (tail (tail str))

{-Toma sólo las horas. Evita error cuando no hay registro-}
tomarHoraString :: String -> Int
tomarHoraString "" = -1
tomarHoraString n = read (takeWhile (/= ':') n) :: Int

{-Toma sólo los minutos. Evita error cuando no hay registro-}
tomarMinutoString :: String -> Int
tomarMinutoString "" = -1
tomarMinutoString n = read (drop 3 n) :: Int

crearHoras :: (String,String) -> (Hora,Hora)
crearHoras (x,y) = (Hora (tomarHoraString x) (tomarMinutoString x), Hora (tomarHoraString y) (tomarMinutoString y))

{-Sumar horas de las tuplas-}
sumarHoras :: (Hora,Hora) -> Int
sumarHoras (x,y) 
            | hora x == -1 || hora y == -1 = 0
            | otherwise = diferenciaHoraria x y

{-tomarTuplas-}
tomarTuplas :: [(String,String)] -> [(Hora,Hora)]
tomarTuplas = map crearHoras

acumularHoras :: [Int] -> Int
acumularHoras [] = 0
acumularHoras x = head x + acumularHoras (tail x)

unirStrings :: [(String,String)] -> String
unirStrings [] = ""
unirStrings ((_, _):_:_) = ""
unirStrings [(x,y)] = x ++ " " ++ y

mostrarResultado :: (String,String) -> String
mostrarResultado (x,y) = x ++ " " ++ y

-- , "\"Total"