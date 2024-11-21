# Configurazione di Jenkins Master e Slave su Rocky Linux 9

Questo progetto automatizza la creazione di un ambiente **Rocky Linux 9** utilizzando **Vagrant** e la configurazione di **Jenkins Master** e **Slave** tramite **Ansible**. 

## Obiettivo

L'obiettivo di questo progetto è:
1. Creare una macchina virtuale con **Vagrant** utilizzando Rocky Linux 9.
2. Installare e configurare **Docker** sulla VM.
3. Creare una rete Docker personalizzata con un IP statico.
4. Configurare un container **Jenkins Master** con porte forwardate per l'accesso locale.
5. Configurare un container **Jenkins Slave** connesso al Master tramite un IP statico.

Al termine, sarà possibile accedere:
- All'interfaccia web di Jenkins dal browser su [http://localhost:8080](http://localhost:8080).
- Al servizio remoto del Jenkins Master sulla porta `50000` tramite [http://localhost:50000](http://localhost:50000).

## File del progetto

### `Vagrantfile`
Definisce la configurazione della VM:
- Utilizza la box **Rocky Linux 9**.
- Configura una rete privata con IP statico `192.168.56.10`.
- Abilita il port forwarding per le porte `8080` e `50000` (necessarie per Jenkins).
- Specifica l'uso di **Ansible** per il provisioning.

### `provision.yml`
Il playbook Ansible esegue le seguenti attività:
1. Aggiorna i pacchetti e installa i prerequisiti per Docker.
2. Installa **Docker CE** e avvia il servizio.
3. Configura una rete Docker personalizzata chiamata `jenkins_network` con un IP statico.
4. Esegue un container **Jenkins Master** configurato per l'accesso su `localhost:8080` e `localhost:50000`.
5. Esegue un container **Jenkins Slave**, connesso al Master tramite la rete Docker.

### `ansible.cfg`
Contiene le configurazioni per:
- Inventario statico dei nodi Ansible.
- Chiavi SSH per la connessione alla VM.
- Interprete Python per eseguire i comandi Ansible.

### `hosts`
Definisce l'inventario statico di Ansible, con la VM accessibile tramite l'IP `192.168.56.10`.

## Accesso ai Servizi

Dopo aver eseguito il provisioning, è possibile accedere ai servizi Jenkins come segue:
- **Interfaccia Web Jenkins Master**: [http://localhost:8080](http://localhost:8080).
- **Porta remota del Jenkins Master**: [http://localhost:50000](http://localhost:50000).

## Come Usare il Progetto

1. Clona questo repository sul tuo computer.
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Avvia la VM con Vagrant:
   ```bash
   vagrant up
   ```
3. Accedi alla VM:
   ```bash
   vagrant ssh
   ```

4. Verifica lo stato dei container Docker nella VM:
   ```bash
   sudo watch docker ps -a
   ```

5.	Configura Jenkins tramite il browser:
- Apri http://localhost:8080 nel browser.
- Recupera la password di amministratore iniziale accedendo al container jenkins_master:
   ```bash
   sudo docker exec jenkins_master cat /var/jenkins_home/secrets/initialAdminPassword
   ```

- Incolla la password nella schermata del browser e segui la procedura guidata.
- Installa i plugin suggeriti.
- Continuare come amministratore, saltando la creazione del primo utente amministratore.

6.	Configura il nodo agente slave:
- Vai su Gestisci Jenkins > Nodes > New Node.
- Inserisci un nome per il nodo (es. slave) e seleziona Agente permanente.
- Configura i dettagli del nodo:
- Nome: slave
- Directory radice remota: /home/jenkins
- Metodo di avvio: Avvia l'agente facendolo connettere al master.
- Salva il nodo e, nella schermata del nodo appena creato, copia il jenkins_secret.

7.	Aggiorna il file provision.yml:
- Nel file provision.yml, sostituisci il valore di JENKINS_SECRET nella sezione env dello Slave con quello copiato:
   ```bash
   env:
     JENKINS_URL: http://172.20.0.2:8080
     JENKINS_AGENT_NAME: "slave"
     JENKINS_AGENT_WORKDIR: "/home/jenkins"
     JENKINS_SECRET: "jenkins_secret"  # Sostituisci con la chiave segreta del Master
   ```

- Applica nuovamente il provisioning:
   ```bash
   vagrant provision
   ```

8.	Verifica che l’agente sia connesso:
- Vai su Gestisci Jenkins > Nodes e assicurati che il nodo sia connesso.


## Note

- Assicurati di avere Vagrant e VirtualBox installati sul tuo sistema.
- Questo progetto è stato testato su processori Intel e potrebbe non funzionare su dispositivi Apple Silicon ARM.

## Requisiti

- Vagrant 2.2.19 o successivo
- VirtualBox 6.1 o successivo
- Ansible 2.9 o successivo
- Connessione a Internet per scaricare le immagini e i pacchetti richiesti.

## Risoluzione dei Problemi

- **Errore di connessione alla VM**: Assicurati che VirtualBox sia configurato correttamente e che Vagrant utilizzi la versione corretta del provider.
- **Jenkins non accessibile**: Verifica che i container Docker siano in esecuzione tramite docker ps e controlla eventuali errori nei log.
