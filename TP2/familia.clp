(defrule hermanos
    (padre-de ?papa ?hijo)
    (madre-de ?mama ?hijo)
    (hombre ?hijo)
    (padre-de ?papa ?hija)
    (madre-de ?mama ?hija)
    (mujer ?hija)
=>
    (assert (Hermano ?hijo ?hija))
    (assert (Hermana ?hija ?hijo))
)

(defrule abuelo-paterno
    (padre-de ?papa ?nieto)
    (padre-de ?abuelo ?papa)
    (hombre ?abuelo)
=>    
    (assert (Abuelo ?abuelo ?nieto))
)

(defrule abuelo-materno
    (madre-de ?mama ?nieto)
    (padre-de ?abuelo ?mama)
    (hombre ?abuelo)
=>    
    (assert (Abuelo ?abuelo ?nieto))
)

(defrule abuela-paterna
    (padre-de ?papa ?nieto)
    (madre-de ?abuela ?papa)
    (mujer ?abuela)
=>    
    (assert (Abuela ?abuela ?nieto))
)

(defrule abuela-materna
    (madre-de ?mama ?nieto)
    (madre-de ?abuela ?mama)
    (mujer ?abuela)
=>    
    (assert (Abuela ?abuela ?nieto))
)

(defrule abuelos
    (mujer-de ?abuela ?abuelo)
    (esposo-de ?abuelo ?abuela)
    (Abuelo ?abuelo ?nieto)
    (Abuela ?abuela ?nieto)
=>
    (assert (Abuelos ?abuelo ?abuela ?nieto))
)
