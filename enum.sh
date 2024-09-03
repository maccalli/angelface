#!/bin/bash

# Definindo cores
RED="\033[0;31m"
NC="\033[0m"
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
WHITE="\033[1;37m"

echo -e "${YELLOW}
█ ▄▄  ██   █▄▄▄▄   ▄▄▄▄▄   ▄█    ▄     ▄▀       ▄  █    ▄▄▄▄▀ █▀▄▀█ █     
█   █ █ █  █  ▄▀  █     ▀▄ ██     █  ▄▀        █   █ ▀▀▀ █    █ █ █ █     
█▀▀▀  █▄▄█ █▀▀▌ ▄  ▀▀▀▀▄   ██ ██   █ █ ▀▄      ██▀▀█     █    █ ▄ █ █     
█     █  █ █  █  ▀▄▄▄▄▀    ▐█ █ █  █ █   █     █   █    █     █   █ ███▄  
 █       █   █              ▐ █  █ █  ███         █    ▀         █      ▀ 
  ▀     █   ▀                 █   ██             ▀              ▀         
       ▀                                                              
                                                                    
                   1111111111111                  
              1#####################1             
           1######111111111111111######1          
         1###11111111111111111111111#1###1        
       1####1111111111111111111111111111###1      
      1##1#1111111111########1111111111111##1     
     ###11111111########1 ########111111111###    
    ###1111111########1     ########11111111###   
   1##111111########1         ########1111111##1  
   ##11111########1            1########111111##1 
  ##11111#############     #####1########111111## 
  ##1111########     #### ##     1########11111## 
  ##1111#######1        ##        ######1##1111## 
  #1111########       ## # ##      ######1#11111# 
  ##111#1######       ## # ##      ######1#11111# 
  #1111##1######        ###       1#####11#11111# 
  ##111##1######1     ### ##      ######1##1111## 
  1##111#11############     #### ######11#1111##1 
   ###11##11#######1           #######11##111###  
   1##111##111#######        1######111##1111##1  
    1##1111##111#######1   #######111###1111##1   
     1###111###11111##########11111###11111##1    
      1###1111#####1111###11111#####11111###1     
        1##111111################1111111##1       
          ##1111111111####1111111111111#1         
          ###11111111##11##11111111111###         
        1##11#1##111111111#111111#####11##        
       1##111111#####1#1##########1111111##       
       ###11111111111111##11#1111111111111##      
      1#1111#11111111111##11111111111111111#1     
      ##111#111111111111##1111111111111#111##     
     1#111##111111111111##1111111111111#1111#1    
     #######111111111111##1111111111111#######    
    #########11111111111##111111111111#########   
    #########11111111111##111111111111#########   
    1######1111111111111##11111111111111######1   
      1111#1111111111111##11111111111111#1111     
          ###11111111111##111111111111###         
          ###############################         
        1################1################1     
        
=======================================================================================================  
${NC}"

# Checar parâmetros e realizar a pesquisa inicial, se necessário
if [ "$1" != "" ]
then
    echo -e "${WHITE}\033[41mIniciando pesquisa com o parâmetro: $1${NC}"

    # Executando wget e capturando a saída
    wget_output=$(wget "$1" 2>&1)
    
    # Extraindo o nome do arquivo da saída
    file_name=$(echo "$wget_output" | grep -oP "(?<=Saving to: ‘)[^’]+")
    
    if [ -n "$file_name" ]
    then
        echo -e "${GREEN}Arquivo baixado: $file_name${NC}"
        echo -e "${GREEN}Efetuando análise" | grep href $file_name | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l" > lista
        for url in $(cat lista);
        do
        host $url | grep "has address";
        done
    else
        echo -e "${RED}Não foi possível determinar o nome do arquivo.${NC}"
    fi

else
    echo -e "${WHITE}\033[41mEAE CARA, ESQUECEU DOS PARAMETROS????????${NC}"
    echo -e "${WHITE}\033[41mModo de uso: $0 REDE | Exemplo: $0 example.com${NC}"
fi

# Loop para repetir a pesquisa baseado na entrada do usuário
while true
do
    echo -e "${GREEN}Nova Pesquisa? Y/N${NC}"
    read pesquisa

    if [ "$pesquisa" == "y" ] || [ "$pesquisa" == "Y" ]
    then
        echo -e "${WHITE}\033[41mModo de uso: $0 REDE | Exemplo: $0 example.com${NC}"
        read -p "Digite o novo parâmetro: " novo_parametro

        if [ "$novo_parametro" != "" ]
        then
            # Executando wget e capturando a saída
            wget_output=$(wget "$novo_parametro" 2>&1)
            
            # Extraindo o nome do arquivo da saída
            file_name=$(echo "$wget_output" | grep -oP "(?<=Saving to: ‘)[^’]+")
            
            if [ -n "$file_name" ]
            then
                echo -e "${GREEN}Arquivo baixado: $file_name${NC}"
                echo -e "${GREEN}Efetuando análise" | grep href $file_name | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l"
                
            else
                echo -e "${RED}Não foi possível determinar o nome do arquivo.${NC}"
            fi

        else
            echo -e "${WHITE}\033[41mParâmetro vazio. Nenhuma ação foi realizada.${NC}"
        fi

    elif [ "$pesquisa" == "n" ] || [ "$pesquisa" == "N" ]
    then
        echo "Saindo..."
        break

    else
        echo -e "${RED}Entrada inválida. Por favor, digite 'Y' para sim ou 'N' para não.${NC}"
    fi
done
