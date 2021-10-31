module DataHora
(
  Hora(..),
  getHora,
  getMinuto,
  desnormalizar,
  tomarHora,
  tomarMinuto,
  normalizar,
  diferenciaHoraria,
) where  


-- Tipo de datos Hora
data Hora = Hora { hora :: Int , minuto :: Int }


-- Redefinimos el Show para el tipo de datos Hora
instance Show Hora where
  show (Hora h m) = show h ++ ":" ++ show m 


-- Getter de hora y minuto

getHora :: Hora -> Int
getHora = hora

getMinuto :: Hora -> Int 
getMinuto = minuto


-- Normalizacion y desnormalizacion a minutos

desnormalizar :: Hora -> Int
desnormalizar h = 60 * getHora h + getMinuto h

tomarHora :: Int -> Int 
tomarHora h = h `div` 60

tomarMinuto :: Int -> Int 
tomarMinuto h = h `mod` 60

normalizar :: Int -> Hora
normalizar x = Hora (tomarHora x) (tomarMinuto x)


-- Diferencia de tiempo

diferenciaHoraria :: Hora -> Hora -> Int
diferenciaHoraria h1 h2 = abs (desnormalizar h1 - desnormalizar h2)






