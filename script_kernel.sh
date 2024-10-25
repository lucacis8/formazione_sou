#!/bin/bash

# Ottieni la versione del kernel attualmente in esecuzione
current_kernel=$(uname -r)

# Elenca tutte le versioni del kernel installate, considerando solo i pacchetti con numeri di versione
installed_kernels=$(dpkg --list | grep 'linux-image-.*-generic' | awk '{print $2}' | sed 's/linux-image-//' | sort -V)

# Ottieni l'ultima versione del kernel installata
latest_kernel=$(echo "$installed_kernels" | tail -n 1)

# Confronta il kernel in esecuzione con l'ultimo installato
if [ "$current_kernel" = "$latest_kernel" ]; then
    echo "TRUE: Il kernel in esecuzione ($current_kernel) è il più recente installato."
    exit 0
else
    echo "FALSE: Il kernel in esecuzione ($current_kernel) non è il più recente. L'ultima versione installata è $latest_kernel."
    exit 1
fi
