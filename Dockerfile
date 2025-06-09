# Etapa 1: Build do projeto
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o projeto inteiro (pom.xml + src/ + etc.)
COPY . .

# Constrói o projeto e ignora os testes
RUN mvn clean install -DskipTests

# Etapa 2: Imagem final para execução
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copia o JAR gerado na etapa de build
COPY --from=build /app/target/*.jar app.jar

# Expõe a porta 8080
EXPOSE 8080

# Comando de inicialização da aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
