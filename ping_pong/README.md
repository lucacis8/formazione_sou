# Vagrant Docker Node Setup

Questo progetto utilizza Vagrant per creare e configurare due macchine virtuali (`node1` e `node2`) su Ubuntu 18.04 (Bionic). Ogni nodo è configurato con Docker e un servizio `echo-server` che viene gestito alternativamente ogni minuto tramite uno script cron.

## Prerequisiti

Assicurati di avere installato:

- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/)

## Configurazione del Progetto

Il `Vagrantfile` configura due macchine virtuali con indirizzi IP statici:

- **`node1`** - IP: `192.168.50.10`
- **`node2`** - IP: `192.168.50.11`

Entrambi i nodi installano Docker e avviano un container `echo-server` basato sull'immagine `ealen/echo-server`. Uno script `cron` alterna ogni minuto l’esecuzione del container tra i due nodi.

## Guida all'Uso

1. **Clona il repository**:
   ```bash
   git clone https://github.com/lucacis8/formazione_sou/
   cd formazione_sou/ping_pong
   ```

2. **Avvia Vagrant**:
   ```bash
   vagrant up
   ```
   Questo comando crea e configura le macchine virtuali, installa Docker e configura il servizio `echo-server` con la logica di alternanza.

3. **Verifica dell'Installazione**:
   - Accedi ai nodi:
     ```bash
     vagrant ssh node1
     ```
     o
     ```bash
     vagrant ssh node2
     ```
   - Controlla lo stato dei container Docker:
     ```bash
     docker ps
     ```

## Dettagli della Configurazione

- **Vagrantfile**: Configura i nodi `node1` e `node2`, gestisce l'installazione di Docker e crea i container `echo-server`.
- **Script di Gestione `manage_ping_pong.sh`**: Uno script eseguito da cron alterna l'attivazione dei container `echo-server` ogni minuto. Nei minuti pari viene attivato `echo-server` su `node2`, mentre nei minuti dispari su `node1`.

## Configurazione di Cron

Lo script `manage_ping_pong.sh` viene eseguito ogni minuto tramite cron e alterna l’esecuzione del container:

- **Minuti pari**: Avvia `echo-server-node2` e arresta `echo-server-node1`.
- **Minuti dispari**: Avvia `echo-server-node1` e arresta `echo-server-node2`.

La configurazione di cron è impostata automaticamente nel provisioning del Vagrantfile.

## Note

- **Provisioning Idempotente**: Il `Vagrantfile` include controlli per l’installazione di Docker e la creazione dei container, assicurando che il provisioning possa essere eseguito più volte senza problemi.
- **Riesecuzione del Provisioning**: Se necessario, puoi rieseguire il provisioning con:
  ```bash
  vagrant provision
  ```

## Troubleshooting

- **Problemi con Docker**: Se Docker non viene avviato correttamente, prova a riavviare la macchina virtuale:
  ```bash
  vagrant reload node1
  ```
  o
  ```bash
  vagrant reload node2
  ```

- **Verifica cron**: Assicurati che cron sia configurato correttamente, controllando il crontab corrente su ciascun nodo:
  ```bash
  crontab -l
  ```

## Rimozione del Progetto

Per fermare e rimuovere le macchine virtuali:

```bash
vagrant destroy -f
```

## Autore

Progetto configurato da Luca.
