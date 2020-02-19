#!/bin/bash

# Funcao que converte a imagem
converte_imagem(){
    local caminho_imagem=$1
    local imagem_sem_extensao=$(ls $caminho_imagem | awk -F. '{ print $1 }')
    convert $imagem_sem_extensao.jpg $imagem_sem_extensao.png
}

# Funcao que varre o diretorio procurando novos diretorios
varrer_diretorio() {
    cd $1
    for arquivo in *
    do
        local caminho_arquivo=$(find $caminho -name $arquivo)
        if [ -d $arquivo ]
        then
            varrer_diretorio $arquivo
        else
            converte_imagem $caminho_arquivo
        fi
    done
}

# Chamada da funcao que varre o diretorio base
# A conversao eh realizada em todas as imagens dentro do diretorio
# passado como parametro e em todas imagens dos subdiretorios
# Todas mensagens de erros sao salvas em um arquivo texto separado
caminho=$(find ~/ -name $1)
varrer_diretorio $caminho 2>erros_conversao.txt

# Verificacao se a conversao ocorreu com sucesso
if [ $? -eq 0 ]
then
    echo "Conversao realizada com sucesso"
else
    echo "Houve um erro na conversao"
fi
