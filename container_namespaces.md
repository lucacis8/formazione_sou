Esercizio Container/Namespaces

Scopo:
Comprensione e utilizzo dei namespaces in relazione ai container .1

Introduzione:
I namespaces sono una feature del kernel di Linux che consente di
restringere la visibilità di un processo a le varie risorse di sistema.
Esistono diversi tipi di namespace per ogni tipologia di risorsa:
• pid: processi
• mnt: mountpoint
• net: interfacce di rete
• user: utenti
• ipc: shared memory e interprocess communication
• time: clock di sistema
I namespaces associati ai vari processi vengono esposti dal kernel
attraverso il filesystem /proc (/proc/<pid>/ns/).

Obiettivo:
Riuscire a lanciare un processo con lo stesso namespace di un container e
visualizzare tale processo con una ps dentro al container.
Tip (1): utilizzare il comando nsenter per lanciare il comando. Sulla
manpage ci sono tutte le informazioni per "agganciare" il nuovo processo
agli stessi stesso namespaces di un processo esistente (attenzione,
occorre agganciare "tutti" i namespace del processo target).
Tip (2): utilizzare la docker/podman inspect per sapere il pid del processo
da associare al container.

L’esercizio può essere svolto sia con Docker che con PodMan o altro container management 1
tool a scelta.

Domande
1. Il PID del processo lanciato è uguale o diverso tra dentro e fuori il
container ?
2. Cosa succede se si prova a stoppare il container mentre il processo
creato è ancora attivo ?
3. Cosa succede se si prova a killare il processo da dentro il container ?
