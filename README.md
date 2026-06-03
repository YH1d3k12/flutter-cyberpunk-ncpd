# 🚔 Flutter Cyberpunk NCPD Project

Sistema de gerenciamento policial inspirado no universo Cyberpunk 2077. O objetivo do projeto é fornecer uma plataforma de investigação criminal utilizada exclusivamente por agentes autorizados da NCPD, permitindo o gerenciamento de cidadãos, criminosos, veículos, evidências, incidentes e investigações.

## 🏗 Arquitetura do Projeto

O projeto utiliza uma arquitetura baseada nos seguintes pilares:
* Feature-Based Architecture
* Domain Driven Design (DDD Simplificado)
* Repository Pattern
* Clean Separation of Concerns
* Banco de Dados Local: SQLite + Floor ORM

## 📂 Estrutura de Diretórios
Toda funcionalidade segue estritamente o fluxo de dependência: **Data → Domain → Presentation**.
* `Presentation`: Interface (Screens, Widgets). Zero regras de negócio ou SQL.
* `Domain`: Coração lógico (Models, Services, Repository Contracts).
* `Data`: Persistência (Entities, DAOs, Mappers, Repository Implementations).
* `Database`: Infraestrutura (Floor, Migrations).
* `Core`: Recursos globais.
* `Shared`: Componentes visuais do Design System NCPD.

## 🚀 Como Executar

1. Clone o repositório:
   `git clone https://github.com/YH1d3k12/flutter-cyberpunk-ncpd.git`
2. Instale as dependências:
   `flutter pub get`
3. Gere os arquivos do banco de dados (Floor):
   `flutter pub run build_runner build --delete-conflicting-outputs`
4. Execute o projeto (Multiplataforma habilitada):
   `flutter run`