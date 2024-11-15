# Esercizio Container/CGroups

## Scopo
Comprendere e utilizzare i Control Groups (CGroups) in relazione ai container.

## Introduzione
I CGroups (control groups) sono una funzionalità del kernel Linux che consente di limitare l'uso delle risorse di sistema (RAM, CPU, I/O, ecc.) da parte di un processo.  
I limiti imposti su ogni CGroup vengono esposti dal kernel attraverso il percorso `/sys/fs/cgroup` nel filesystem `/sys`.

In un container Docker, i limiti delle risorse si trovano all'interno del percorso `/sys/fs/cgroup/system.slice/docker-<id>.scope`, dove `<id>` è l'ID del container, visualizzabile allo start.  
Ad esempio, la memoria massima assegnabile a un CGroup è rappresentata dal file `memory.max` in questo percorso. Docker imposta questo parametro tramite l'opzione `--memory=<N>` al momento del run del container.  
Questo file è scrivibile, quindi può essere modificato dinamicamente. Opzioni analoghe sono disponibili anche in altri container manager come Podman o Moby.

## Obiettivo
- Avviare un container (con tecnologia a scelta) all'interno di un host o VM Linux, impostando una restrizione sulla memoria.
- All'interno del container, eseguire il comando `free` per visualizzare la memoria attualmente occupata.
- Modificare il file `memory.max` impostando un valore inferiore alla memoria attualmente utilizzata, fino a provocare l'uccisione del container da parte dell'OOM Killer (Out Of Memory Killer) del kernel.

## Passaggi

1. **Avvio del container con limite di memoria**
   - Eseguire il container impostando un limite iniziale di memoria, ad esempio:
     ```bash
     docker run -d --memory=512m --name test_container ubuntu sleep infinity
     ```

2. **Verifica della memoria attualmente occupata nel container**
   - Entrare nel container:
     ```bash
     docker exec -it test_container /bin/bash
     ```
   - All'interno del container, eseguire il comando:
     ```bash
     free -m
     ```
   - Annotare la memoria attualmente occupata.

3. **Impostare un nuovo limite `memory.max` inferiore**
   - Identificare l'ID del container:
     ```bash
     docker ps -qf "name=test_container"
     ```
   - Modificare il file `memory.max` per ridurre la memoria massima disponibile:
     ```bash
     echo "256M" > /sys/fs/cgroup/system.slice/docker-<id>.scope/memory.max
     ```
   - Nota: sostituire `<id>` con l'ID del container ottenuto in precedenza.

4. **Osservare il comportamento del container**
   - Dopo la modifica, monitorare se e quando il container viene terminato dall'OOM Killer.
   - Annotare il comportamento e le tempistiche.

## Domande e Risposte

1. **L'uccisione da parte dell'OOM Killer è istantanea?**
   - La risposta può variare. L'OOM Killer del kernel può non agire istantaneamente. Questo può dipendere dal carico di memoria del sistema, dalla frequenza con cui il kernel verifica le risorse e dalle policy di gestione della memoria. Se il sistema è sotto stress, l'OOM Killer potrebbe intervenire più rapidamente.

2. **Cosa succede quando `memory.max` è inferiore alla memoria utilizzata?**
   - Il kernel tenterà di liberare memoria per rispettare il nuovo limite. Tuttavia, se il limite è inferiore alla memoria attiva utilizzata dal container, e non è possibile deallocarla immediatamente, il container potrebbe continuare a funzionare brevemente prima che l'OOM Killer lo termini. La ragione è che la deallocazione istantanea potrebbe non essere possibile, specialmente se la memoria è attivamente in uso e frammentata.

## Riferimenti
- [Docker documentation on memory constraints](https://docs.docker.com/config/containers/resource_constraints/)
- [Linux CGroups documentation](https://www.kernel.org/doc/Documentation/cgroup-v2.txt)
