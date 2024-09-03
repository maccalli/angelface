#!/bin/bash

# Defina o endereço IP do servidor que está configurado para Port Knocking
SERVER_IP="37.59.174.235"

# Sequência de portas para knocking
PORTS=(13 37 30000 3000 1337)

# Função para bater na porta especificada usando netcat
knock() {
  local port=$1
  echo "Batendo na porta $port..."
  # Tenta conectar à porta especificada no servidor com um timeout de 0.5 segundos
  nc -v  $SERVER_IP $port
}

# Itera sobre todas as portas na sequência definida
for port in "${PORTS[@]}"; do
  knock $port
done

echo "Sequência de Port Knocking completa."
