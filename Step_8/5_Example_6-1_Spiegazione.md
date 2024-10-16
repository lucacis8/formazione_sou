Questo script fa vedere come il sistema inserisca un valore in base all'esecuzione di un comando.
Nel primo caso viene usato echo per stampare un messaggio.
Nella riga successiva, viene stampato "0" per il fatto che il comando precedente ha avuto successo.
Nel secondo caso, essendo lskdf un comando non valido, viene stampato un numero diverso da "0", solitamente "127".
Lo script termina, ma al suo interno si viene invitati a digitare echo$? per poter avere il numero relativo all'uscita, ovvero "113".
