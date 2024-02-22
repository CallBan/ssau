/* comment */
father(petya, kolya).
father(petya, mark).
brother(kolya, mark).
brother(genya, petya).
uncle(X, Y):-brother(X, Z), father(Z, Y).
