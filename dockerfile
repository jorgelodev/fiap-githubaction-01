FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
# Copia os arquivos publicados do estágio de construção
COPY --from=build-env /app/out .
# Define o comando de inicialização do aplicativo
ENTRYPOINT ["dotnet", "WebAppDocker.dll"]
