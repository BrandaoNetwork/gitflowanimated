# 1. Use uma imagem base com Node.js e npm
FROM node:18 AS build

# 2. Defina o diretório de trabalho no contêiner
WORKDIR /app

# 3. Copie os arquivos de dependências para o contêiner
COPY package.json ./

# 4. Instale as dependências
RUN npm install

# 5. Copie o código da aplicação para o contêiner
COPY . .

# 6. Execute o build da aplicação
RUN npm run build

# 7. Use uma imagem base menor para o ambiente de produção
FROM nginx:alpine AS production

# 8. Copie os arquivos de build do estágio anterior para o diretório do Nginx
COPY --from=build /app/build /usr/share/nginx/html

# 9. Expõe a porta 80
EXPOSE 80

# 10. Inicie o Nginx quando o contêiner for executado
CMD ["nginx", "-g", "daemon off;"]
