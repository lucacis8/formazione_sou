Questo script fa una pulizia dei file di log in un sistema Linux.
Prima di tutto si sposta nella directory /var/log.
Poi va a spostare il contenuto di dev/null (che è un file speciale) all'interno dei file messages e wtmp.
Infine stampa il messaggio "Log files cleaned up".
Questo script non elimina i file, ma li svuota, e per essere eseguito bisogna avere i privilegi di root.
