#!/bin/bash

# Defina o endereço IP do servidor que está configurado para Port Knocking
SERVER_IP="37.59.174.235"

# Sequência de portas para knocking
PORTS=(2424 2525)

# Função para enviar um pacote SYN para a porta especificada
send_syn() {
  local port=$1
  echo "Enviando pacote SYN para a porta $port..."
  # Envia um pacote SYN para a porta especificada
  hping3 -S -p $port $SERVER_IP -c 1
}

# Itera sobre todas as portas na sequência definida
for port in "${PORTS[@]}"; do
  send_syn $port
done

echo "Sequência de Port Knocking completa."
