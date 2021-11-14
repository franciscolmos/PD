criaDe(cachorro, perro).
criaDe(lobezno, lobo).
criaDe(ternero, vaca).
criaDe(potrillo, caballo).
criaDe(cordero, oveja).
criaDe(chulengo, guanaco).
criaDe(pollo, gallina).
criaDe(renacuajo, rana).

comeCarne(perro).
comeCarne(lobo).
comeCarne(A) :- criaDe(A,B), comeCarne(B).

comeHierba(vaca).
comeHierba(caballo).
comeHierba(oveja).
comeHierba(guanaco).
comeHierba(gallina).
comeHierba(rana).
comeHierba(A) :- criaDe(A,B), comeHierba(B).

animal(perro).
animal(lobo).
animal(vaca).
animal(caballo).
animal(oveja).
animal(guanaco).
animal(gallina).
animal(rana).
animal(A) :- criaDe(A,B), animal(B).

plumas(gallina).
plumas(A) :- criaDe(A,B), plumas(B).

pelo(perro).
pelo(lobo).
pelo(caballo).
pelo(oveja).
pelo(guanaco).
pelo(A) :- criaDe(A,B), pelo(B).

piel(vaca).
piel(rana).
piel(A) :- criaDe(A,B), piel(B).

puedeComer(A,B) :- comeCarne(A), animal(A), animal(B).
dosPatas(A) :- plumas(A).
cuatroPatas(A) :- pelo(A); piel(A).
