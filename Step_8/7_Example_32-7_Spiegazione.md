Questo script, richiamabile con bash, ma non con sh, fa partire un intervallo in foreground.
La bash si interrompe e viene stampato il testo "Long running process" seguito da dei puntini di caricamento.
Il processo dura 10 secondi e termina con il testo "Finished!" e il ritorno nella bash.
Con ^C è comunque sempre possibile interrompere il processo e ritornare prima nella bash.
