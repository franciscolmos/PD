
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

        cantidadEmpleados = filter buscarCantEmpleados lineas

        intCantidadEmpleados = read $ filter (`elem` "0123456789") (unwords cantidadEmpleados) :: Int
        stringCantidadEmpleados = ["\n" ++ filter (`notElem` "\"\"") (unwords cantidadEmpleados)] 


        tuplas = map hacerTuplas matrizIngresosEgresos

        diaFecha = map (unirStrings . take 1) tuplas
        horarios = map (tomarTuplas . drop 1) tuplas

        horasSumadas = map (map sumarHoras) horarios
        horasAcumuladas = map acumularHoras horasSumadas
        horasNormalizadas = map normalizar horasAcumuladas
        stringHoras = map show horasNormalizadas

        floatHorasAcumuladas = fromIntegral (sum horasAcumuladas) / 60

        stringHorasAcumuladas =  ["\nCantidad de horas acumuladas en el mes: " ++ show floatHorasAcumuladas ++ " hs"]

        resultado = zip diaFecha stringHoras

        stringRegistrosEmpleados = map mostrarResultado resultado

        floatHorasHombre =  floatHorasAcumuladas / fromIntegral intCantidadEmpleados
        stringHorasHombre = ["\nCantidad de horas/hombre en el mes: " ++ show stringHorasHombre ++ " hs"]

        stringAvgHorasHombre = ["\nPromedio diario de horas/hombre: " ++ show (floatHorasHombre / 30) ++ " hs"]
        --intAvgHorasHombre = floatHorasHombre / 30

        informe = stringRegistrosEmpleados ++ stringCantidadEmpleados ++ stringHorasAcumuladas ++ stringHorasHombre ++ stringAvgHorasHombre



    --print intAvgHorasHombre
    putStrLn $ unlines informe
    hClose archivo


{- Toma el texto y le quito los renglones que no tienen dias -}
filtrarRenglones :: String -> Bool
filtrarRenglones str | str == "\r" = False
                     | otherwise = (!! 0) (words str) `elem` ["\"Lunes\"", "\"Martes\"", "\"Miercoles\"", "\"Jueves\"", "\"Viernes\""]

buscarCantEmpleados :: String -> Bool
buscarCantEmpleados str | str == "\r" = False
                        | otherwise = (!! 0) (words str) == "\"Total"
       

hacerTuplas :: [String] -> [(String, String)]
hacerTuplas [] = []
hacerTuplas str = ((!!0) str, (!!1) str) : hacerTuplas (tail (tail str))

{- Toma sólo las horas. Evita error cuando no hay registro -}
tomarHoraString :: String -> Int
tomarHoraString "" = -1
tomarHoraString n = read (takeWhile (/= ':') n) :: Int

{- Toma sólo los minutos. Evita error cuando no hay registro -}
tomarMinutoString :: String -> Int
tomarMinutoString "" = -1
tomarMinutoString n = read (drop 3 n) :: Int

crearHoras :: (String,String) -> (Hora,Hora)
crearHoras (x,y) = (Hora (tomarHoraString x) (tomarMinutoString x), Hora (tomarHoraString y) (tomarMinutoString y))

{- Sumar horas de las tuplas -}
sumarHoras :: (Hora,Hora) -> Int
sumarHoras (x,y) 
            | hora x == -1 || hora y == -1 = 0
            | otherwise = diferenciaHoraria x y

{- tomarTuplas -}
tomarTuplas :: [(String,String)] -> [(Hora,Hora)]
tomarTuplas = map crearHoras

acumularHoras :: [Int] -> Int
acumularHoras [] = 0
acumularHoras x = head x + acumularHoras (tail x)

unirStrings :: [(String,String)] -> String
unirStrings [] = ""
unirStrings ((_, _):_:_) = ""
unirStrings [(x,y)] | x == "Miercoles" = x ++ "\t" ++ y
                    | otherwise = x ++ "\t\t" ++ y

mostrarResultado :: (String,String) -> String
mostrarResultado (x,y) = x ++ "\t" ++ y

-- , "\"Total"