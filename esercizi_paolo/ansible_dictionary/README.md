# Esercizio Ansible: Liste e Dizionari

Questo repository contiene due playbook Ansible sviluppati per esercitarsi con l'utilizzo di liste e dizionari in Ansible.

## Scopo dell'esercizio

L'esercizio ha lo scopo di migliorare la comprensione e l'utilizzo di strutture dati complesse (liste e dizionari) all'interno dei playbook Ansible. Queste strutture dati permettono di definire configurazioni strutturate in modo chiaro e flessibile.

## Descrizione dei playbook

### 1. `install_pacchetti.yml`

Questo playbook permette di installare o disinstallare pacchetti in base a un dizionario che definisce lo stato desiderato per ogni pacchetto:
- `present` per installare il pacchetto.
- `absent` per disinstallare il pacchetto.

#### Variabili

- `pacchetti`: un dizionario che contiene i pacchetti come chiavi e lo stato desiderato come valore (ad es. `{vim: present, git: present, nano: absent}`).

#### Utilizzo

Il playbook può essere lanciato con il comando:

```bash
ansible-playbook install_pacchetti.yml
