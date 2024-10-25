#!/bin/bash

# Verifica che siano passati i parametri target e range di porte
if [ $# -ne 3 ]; then
  echo "Uso: $0 <indirizzo IP> <porta_inizio> <porta_fine>"
  exit 1
fi

# Parametri passati da riga di comando
TARGET_IP=$1
START_PORT=$2
END_PORT=$3

# Ciclo sulle porte specificate
for ((port=$START_PORT; port<=$END_PORT; port++)); do
  # Utilizza nc in modalità verbose (-v) con timeout di 1 secondo (-z -w 1)
  nc -z -v -w 1 $TARGET_IP $port 2>&1 | grep -q "succeeded"
  
  # Se nc ha trovato una porta aperta, mostra il numero
  if [ $? -eq 0 ]; then
    echo "Porta $port è aperta su $TARGET_IP"
  fi
done
