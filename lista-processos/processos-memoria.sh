#!/bin/bash

# Verifica se existe o diretorio para salvar as informacoes dos processos
# Se nao existe, cria-se o diretorio
if [ ! -d log ]
then
    mkdir log
fi

# Funcao que busca os 10 processos com maior consumo de memoria e cria arquivos
# com informacoes sobre os processos
processos_memoria(){
    # Busca os 10 processos com maior consumo de memoria
    # Os processos sao representados por seus IDs
    processos=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])

    # Laco de repeticao que escreve nos arquivos as informacoes dos processos
    for pid in $processos
    do
        # Pega o nome do processo
        nome_processo=$(ps -p $pid -o comm=)
        # Pega o consumo de memoria do processo em KB
        tamanho_processo=$(ps -p $pid -o size | grep [0-9])
        # Escreve no arquivo a data, a hora e o consumo de memoria do processo em MB
        echo "$(date +%F,%H:%M:%S),$(bc <<< "scale=2;$tamanho_processo/1024") MB" >> log/$nome_processo.log
    done
}

processos_memoria

if [ $? -eq 0 ]; then
    echo "Os arquivos foram salvas com sucesso"
else
    echo "Houve um problema na hora de salvar os arquivos"
fi
