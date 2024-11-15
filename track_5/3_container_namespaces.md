# Esercizio Container/Namespaces

Questo esercizio ha lo scopo di approfondire il funzionamento dei namespaces in relazione alla tecnologia dei container su Linux. Utilizzeremo `Docker` o `PodMan` per eseguire un processo con lo stesso namespace di un container e verificare l’isolamento delle risorse di sistema.

## Obiettivi
- Comprendere il funzionamento dei namespaces in Linux.
- Creare e monitorare un processo associato ai namespaces di un container.
- Rispondere a domande chiave sull'isolamento dei PID e il comportamento dei processi in un ambiente containerizzato.

## Introduzione ai Namespaces
I **namespaces** in Linux consentono di limitare la visibilità di risorse di sistema a specifici gruppi di processi. Esistono vari tipi di namespaces:
- **pid**: isola i processi.
- **mnt**: isola i mountpoint (filesystem).
- **net**: isola le interfacce di rete.
- **user**: isola gli utenti.
- **ipc**: isola la memoria condivisa e i meccanismi di comunicazione tra processi.
- **time**: isola l’orologio di sistema.

Il kernel Linux espone i namespaces dei processi attraverso il filesystem `/proc`, specificamente in `/proc/<pid>/ns/`.

## Prerequisiti
- **Docker** o **PodMan** installato.
- **nsenter**: un comando che permette di accedere ai namespaces di un processo esistente.

## Procedura

### 1. Lanciare un Container e Recuperare il PID

Lancia un container semplice (es. `alpine`) che rimanga attivo per un certo tempo:

```bash
docker run -d --name test_container alpine sleep 600
```

Ottieni il PID del processo principale del container con `docker inspect`:

```bash
CONTAINER_PID=$(docker inspect -f '{{.State.Pid}}' test_container)
echo "PID del container: $CONTAINER_PID"
```

### 2. Utilizzare `nsenter` per Agganciare un Processo ai Namespaces del Container

Utilizza `nsenter` per avviare un processo nel contesto dei namespaces del container, collegandoti a **tutti i namespaces** del processo principale del container:

```bash
nsenter --target $CONTAINER_PID --mount --pid --net --ipc --user --uts -- ps aux
```

> **Nota**: Puoi eseguire anche altri comandi oltre a `ps aux` per osservare come il namespace modifica la visibilità delle risorse.

### 3. Osservare il PID

Confronta il PID del processo eseguito sia dentro che fuori dal container.

- **Dentro il container**: Entra nel container e verifica i PID con il comando:
  ```bash
  docker exec -it test_container ps aux
  ```
- **Fuori dal container**: Verifica il PID reale dall'host.

> **Risultato atteso**: Il PID del processo lanciato tramite `nsenter` sarà diverso all'interno del container rispetto all'host, poiché il namespace `pid` isola i PID.

### 4. Sperimentare con `kill` e Stop del Container

1. **Stop del container**:
   - Se stai eseguendo il container con `docker stop test_container`, tutti i processi associati ai suoi namespaces, inclusi quelli avviati tramite `nsenter`, verranno terminati.

2. **Kill del processo dall'interno del container**:
   - Accedi al container e tenta di terminare il processo lanciato tramite `nsenter`:
     ```bash
     docker exec -it test_container /bin/sh
     ```
   - Usa `kill` per terminare il processo e osserva l'effetto sui namespaces e sul container.

## Domande e Risposte

1. **Il PID del processo lanciato è uguale o diverso tra dentro e fuori il container?**
   - **Risposta**: Il PID sarà **diverso**. Il namespace `pid` del container isola la visibilità dei PID, facendo apparire i PID come se fossero parte di un ambiente separato.

2. **Cosa succede se si prova a stoppare il container mentre il processo creato è ancora attivo?**
   - **Risposta**: Tutti i processi legati ai namespaces del container, inclusi quelli creati con `nsenter`, vengono automaticamente terminati quando il container viene stoppato.

3. **Cosa succede se si prova a killare il processo da dentro il container?**
   - **Risposta**: Il processo verrà terminato normalmente. Il kill del processo dall'interno del container ha effetto come su un normale processo, senza alterare il comportamento degli altri processi containerizzati.

## Conclusione
Questo esercizio ha mostrato come i namespaces Linux creano un isolamento delle risorse di sistema nei container, illustrando le somiglianze e le differenze di comportamento tra l’ambiente containerizzato e l’host.
