# Esercizio Ansible: Liste e Dizionari

Questo repository contiene due playbook Ansible sviluppati per esercitarsi con l'utilizzo di liste e dizionari in Ansible.

## Scopo dell'esercizio

L'esercizio ha lo scopo di migliorare la comprensione e l'utilizzo di strutture dati complesse (liste e dizionari) all'interno dei playbook Ansible. Queste strutture dati permettono di definire configurazioni strutturate in modo chiaro e flessibile.

## Descrizione dei playbook

### 1. `installa_pacchetti.yml`

Questo playbook permette di installare o disinstallare pacchetti in base a un dizionario che definisce lo stato desiderato per ogni pacchetto:
- `present` per installare il pacchetto.
- `absent` per disinstallare il pacchetto.

#### Variabili

- `pacchetti`: un dizionario che contiene i pacchetti come chiavi e lo stato desiderato come valore (ad es. `{vim: present, git: present, nano: absent}`).

#### Utilizzo

Il playbook può essere lanciato con il comando:

```bash
ansible-playbook installa_pacchetti.yml
```

### 2. `crea_utenti.yml`

Questo playbook crea una lista di utenti sulla base di una lista di dizionari, dove ogni dizionario rappresenta un utente con le proprie specifiche:
- **name**: nome dell’utente.
- **group**: gruppo dell’utente.
- **home**: directory home dell’utente.
- **shell**: shell di accesso dell’utente.

#### Variabili

- `utenti`: una lista di dizionari, ciascuno contenente i dettagli per ogni utente.

#### Utilizzo

Il playbook può essere eseguito con il comando:

```bash
ansible-playbook crea_utenti.yml
```

### Requisiti

- Ansible installato sulla macchina in uso.
- Permessi sudo per poter installare pacchetti e creare utenti.
