#!/bin/bash

# Funcao que converte imagens
converte_imagens(){
    # Caminho das imagens
    cd $1

    # Verifica se existe o diretorio para salvar as imagens convertidas
    # Se nao existe, cria-se o diretorio
    if [ ! -d png ]
    then
        mkdir png
    fi

    # Laco de repeticao que realiza a conversao em cada imagem
    for imagem in *.jpg
    do
        local nome_imagem=$(ls $imagem | awk -F. '{ print $1 }')
        convert $nome_imagem.jpg png/$nome_imagem.png
    done
}

# Chamada da funcao que converte imagens
# A conversao eh realizada no diretorio que foi passado como parametro
# Todas mensagens de erros sao salvas em um arquivo texto separado
converte_imagens $1 2>erros_conversao.txt

# Verificacao se a conversao ocorreu com sucesso
if [ $? -eq 0 ]
then
    echo "Conversao realizada com sucesso"
else
    echo "Houve um erro na conversao"
fi
