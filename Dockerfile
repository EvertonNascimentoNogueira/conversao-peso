FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY *.sln .
COPY ConversaoPeso.Web/ ./ConversaoPeso.Web/
RUN dotnet restore
COPY ConversaoPeso.Web/. ./ConversaoPeso.Web/
WORKDIR /src/ConversaoPeso.Web
RUN dotnet publish -c release -o /publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /publish
COPY --from=build /publish ./
EXPOSE 80
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]
