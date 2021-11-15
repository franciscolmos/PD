(defrule hermanos
    (padre-de ?hijo ?papa)
    (madre-de ?hijo ?mama)
    (hombre ?hijo)
    (padre-de ?hija ?papa)
    (madre-de ?hija ?mama)
    (mujer ?hija)
=>
    (assert (Hermano-de ?hija ?hijo))
    (assert (Hermana-de ?hijo ?hija))
)

(defrule abuelo-paterno
    (padre-de ?nieto ?papa)
    (padre-de ?papa ?abuelo)
    (hombre ?abuelo)
=>    
    (assert (Abuelo-de ?nieto ?abuelo))
)

(defrule abuelo-materno
    (madre-de ?nieto ?mama)
    (padre-de ?mama ?abuelo)
    (hombre ?abuelo)
=>    
    (assert (Abuelo-de ?nieto ?abuelo))
)

(defrule abuela-paterna
    (padre-de ?nieto ?papa)
    (madre-de ?papa ?abuela)
    (mujer ?abuela)
=>    
    (assert (Abuela-de ?nieto ?abuela))
)

(defrule abuela-materna
    (madre-de ?nieto ?mama)
    (madre-de ?mama ?abuela)
    (mujer ?abuela)
=>    
    (assert (Abuela-de ?nieto ?abuela))
)

(defrule abuelos
    (mujer-de ?abuelo ?abuela)
    (esposo-de ?abuela ?abuelo)
    (Abuelo-de ?nieto ?abuelo)
    (Abuela-de ?nieto ?abuela)
=>
    (assert (Abuelos-de ?nieto ?abuelo ?abuela))
)

(defrule Primo
    (Hermano-de ?madre ?padre)
    (padre-de ?hijo ?padre)
    (madre-de ?hije ?madre)
=>
    (assert (Primo-de ?hijo ?hije))
    (assert (Primo-de ?hije ?hijo))
)

(defrule Tio
    (padre-de ?hijo ?padre)
    (Primo-de ?hijo ?primo)
=>
    (assert (Tio-de ?primo ?padre))
)

(defrule Tia
    (madre-de ?hijo ?madre)
    (Primo-de ?hijo ?primo)
=>
    (assert (Tia-de ?primo ?madre))
)
