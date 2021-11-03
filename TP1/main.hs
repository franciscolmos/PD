
import System.IO (openFile, hGetContents, IOMode (ReadMode), hClose)
import Data.List (isPrefixOf, zip4)
import DataHora

main = do
    -- Leemos el archivo 09septiembre2019.txt y lo guardamos en la variable lineas
    archivo <- openFile "09septiembre2019.txt" ReadMode
    contenido  <- hGetContents archivo
    let lineas = lines contenido

        -- Filramos solo los registros que tengan informacion de los dias trabajados.
        registros = filter filtrarRenglones lineas

        -- Generamos una matriz donde cada fila es un registro de dia trabajado.
        matrizHorarios = map words registros

        -- Quitamos los caracteres sobrantes para una mejor lectura.
        matrizHorariosFiltrada = map (map (filter (`notElem` "\"\""))) matrizHorarios

        -- Generamos las tuplas por cada registro de dia trabajado.
        tuplas = map hacerTuplas matrizHorariosFiltrada

        -- Separamos los dias - fecha de los horarios.
        diaFecha = map (unirStrings . take 1) tuplas

        -- Genaramos los datos de tipo Hora a partir de las tuplas de horario.
        horarios = map (tomarTuplas . drop 1) tuplas

        -- Calculamos la cantidad de minutos trabajados por par ingreso,salida.
        horasSumadas = map (map sumarHoras) horarios

        -- Sumamos los minutos trabajados por empleado por dia.
        horasAcumuladas = map sum horasSumadas

        -- Convertimos los minutos en Horas
        horasNormalizadas = map normalizar horasAcumuladas

        -- convertimos en String las Horas.
        stringHoras = map show horasNormalizadas

        -- Unimos los dias con sus horas trabajadas respectivamente.
        resultado = zip diaFecha stringHoras

        -- Formatemaos el resultado de los registros de cada empleado.
        stringRegistrosEmpleados = map mostrarResultado resultado

        -- Obtenemos la cantidad de empleados
        intCantidadEmpleados = length $ filter buscarCantEmpleados lineas
        stringCantidadEmpleados = ["Total de empleados listados: " ++ show intCantidadEmpleados] 

        -- Calculamos la cantidad de horas acumuladas.
        floatHorasAcumuladas = fromIntegral (sum horasAcumuladas) / 60
        stringHorasAcumuladas =  ["\nCantidad de horas acumuladas en el mes: " ++ show floatHorasAcumuladas ++ " hs"]

        -- Calculamos la cantidad de horas trabajadas por hombre mensualmente
        floatHorasHombre =  floatHorasAcumuladas / fromIntegral intCantidadEmpleados
        stringHorasHombre = ["\nCantidad de horas/hombre en el mes: " ++ show floatHorasHombre ++ " hs"]

        -- Calculamos la el promedio diario de horas/hombre
        intAvgHorasHombre = floatHorasHombre / 20
        stringAvgHorasHombre = ["\nPromedio diario de horas/hombre: " ++ show intAvgHorasHombre ++ " hs"]
        
        -- concatenamos los strings para mostrar el resultado final
        informe = stringRegistrosEmpleados ++ stringCantidadEmpleados ++ stringHorasAcumuladas ++ stringHorasHombre ++ stringAvgHorasHombre

    putStrLn $ unlines informe
    hClose archivo


{- Toma el texto y le quito los renglones que no tienen dias -}
filtrarRenglones :: String -> Bool
filtrarRenglones str | str == "\r" = False
                     | otherwise = (!! 0) (words str) `elem` ["\"Lunes\"", "\"Martes\"", "\"Miercoles\"", "\"Jueves\"", "\"Viernes\""]

{- Obtiene el registro que tiene la cantidad de empleados -}
buscarCantEmpleados :: String -> Bool
buscarCantEmpleados str
                    | str == "\r" = False
                    | otherwise = (!! 0) (words str) == "\"Empleado:\""
       
{- Genera tuplas a partir de cada registro -}
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

{- Permite construir una tupla de Hora -}
crearHoras :: (String,String) -> (Hora,Hora)
crearHoras (x,y) = (Hora (tomarHoraString x) (tomarMinutoString x), Hora (tomarHoraString y) (tomarMinutoString y))

{- Sumar horas de las tuplas -}
sumarHoras :: (Hora,Hora) -> Int
sumarHoras (x,y) 
            | hora x == -1 || hora y == -1 = 0
            | otherwise = diferenciaHoraria x y

{- Convierte una lista de tuplas de String a una lista de tuplas de Hora -}
tomarTuplas :: [(String,String)] -> [(Hora,Hora)]
tomarTuplas = map crearHoras

{- Unimos los dias con su fecha -}
unirStrings :: [(String,String)] -> String
unirStrings [] = ""
unirStrings ((_, _):_:_) = ""
unirStrings [(x,y)] | x == "Miercoles" = x ++ "\t" ++ y
                    | otherwise = x ++ "\t\t" ++ y

{- Formatea el resultado para una mejor visualizacion -}
mostrarResultado :: (String,String) -> String
mostrarResultado (x,y) = x ++ "\t" ++ y
