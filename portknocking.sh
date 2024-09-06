#!/bin/bash

# Defina o endereço IP do servidor que está configurado para Port Knocking
if [ "$1" == "" ]; then
    echo "Modo de uso: $0 REDE"
    echo "Exemplo: $0 172.16.1"
else
    for ip in {1..254}; do
        SERVER_IP=$1.$ip

        # Sequência de portas para knocking (sem vírgulas, separadas por espaços) As portas podem ser alteradas 
        #de acordo com a necessidade
      
        # Exemplo: PORTS=(13 37 30000 3000 1337)
        PORTS=(INCLUDE HERE YOUR PORTS)

        # Função para enviar um pacote SYN para a porta especificada (completamente silenciosa)
        send_syn() {
            local port=$1
            # Envia um pacote SYN para a porta especificada, sem exibir saída
            hping3 -S -p $port $SERVER_IP -c 1 > /dev/null 2>&1
        }

        # Itera sobre todas as portas na sequência definida
        for port in "${PORTS[@]}"; do
            send_syn $port
        done

        # Exibe a mensagem de varredura do host atual
        echo "Varrendo o host $SERVER_IP para validar se a porta 1337 está aberta..."

        # Fazendo a varredura para encontrar a máquina com a porta 1337 aberta e exibindo apenas se aberta
        nmap -p 1337 --open $SERVER_IP | grep "open" > /dev/null

        if [ $? -eq 0 ]; then
            # Exibe apenas o IP se a porta 1337 estiver aberta
            echo "A porta 1337 está aberta no IP $SERVER_IP!"
        else
            echo "Nenhuma porta 1337 aberta no IP $SERVER_IP."
        fi

        echo ""
    done
fi


