# ���������� ����������� ����� .NET
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# ������� ���� �������
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["PorscheDealership.csproj", "./"]
RUN dotnet restore "./PorscheDealership.csproj"
COPY . .
RUN dotnet publish -c Release -o /app/publish

# �������� ��������� �����
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "PorscheDealership.dll"]
