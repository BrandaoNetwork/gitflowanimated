#!/bin/bash

# Nome da imagem e do contêiner
IMAGE_NAME="gitflowanimated"
CONTAINER_NAME="app-react-container"

# Função para construir a imagem Docker se ela não existir
build_image() {
  echo "Construindo a imagem Docker..."
  docker build -t $IMAGE_NAME .
}

# Verifica se a imagem existe
if ! docker images | grep -q "$IMAGE_NAME"; then
  build_image
fi

# Verifica se o contêiner está rodando
if docker ps | grep -q "$CONTAINER_NAME"; then
  echo "O contêiner já está em execução."
else
  # Verifica se o contêiner existe, mas está parado
  if docker ps -a | grep -q "$CONTAINER_NAME"; then
    echo "Iniciando o contêiner parado..."
    docker start $CONTAINER_NAME
  else
    # Executa o contêiner com a aplicação
    echo "Executando o contêiner na porta 80..."
    docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME
  fi
fi

# Exibe o status do contêiner
docker ps | grep "$CONTAINER_NAME"

echo "Acesse a aplicação no navegador em http://localhost"
