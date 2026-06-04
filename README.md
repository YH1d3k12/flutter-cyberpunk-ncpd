# 🚔 Flutter Cyberpunk NCPD Project — MVP

Sistema de gerenciamento policial inspirado no universo Cyberpunk 2077.

---

## 🏗 Arquitetura

```
Data → Domain → Presentation
```

| Camada | Responsabilidade |
|---|---|
| **Presentation** | Screens, Widgets (zero SQL, zero regras) |
| **Domain** | Models, Services, Repository Contracts |
| **Data** | Entities, DAOs, Mappers, Repository Impls |
| **Database** | Floor ORM, SQLite, Converters, Seeds |
| **Core** | Theme, ServiceLocator, SessionManager |

---

## 🚀 Como Executar (MVP)

### 1. Instalar dependências
```bash
flutter pub get
```

### 2. Gerar código do Floor ORM ⚡ (OBRIGATÓRIO)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
> Isso gera `lib/database/app_database.g.dart` automaticamente.

### 3. Executar
```bash
flutter run
```

---

## 🔐 Credenciais Mock (senha: `ncpd2077`)

| Badge     | Nome               | Rank       | Status    |
|-----------|--------------------|------------|-----------|
| NCPD-001  | Viktor Vektor      | CAPTAIN    | ACTIVE    |
| NCPD-002  | River Ward         | DETECTIVE  | ACTIVE    |
| NCPD-003  | Judy Alvarez       | OFFICER    | ACTIVE    |
| NCPD-004  | Panam Palmer       | SERGEANT   | SUSPENDED |
| NCPD-005  | Johnny Silverhand  | ROOKIE     | INACTIVE  |

> Suspended e Inactive são bloqueados no login.

---

## 📂 Estrutura MVP

```
lib/
├── core/
│   ├── services/
│   │   ├── service_locator.dart   ← DI manual (sem pacote externo)
│   │   └── session_manager.dart   ← Sessão do oficial logado
│   └── theme/
│       ├── app_colors.dart
│       ├── app_typography.dart
│       └── app_theme.dart
├── database/
│   ├── app_database.dart          ← @Database Floor (gera .g.dart)
│   ├── converters/
│   │   └── datetime_converter.dart
│   └── seed/
│       └── mock_officers.dart
├── features/
│   ├── auth/                      ← Login refatorado
│   │   ├── domain/repositories/auth_repository.dart
│   │   ├── data/repositories/auth_repository_impl.dart
│   │   └── presentation/screens/login_screen.dart
│   ├── officers/                  ← CRUD completo (exemplo canônico)
│   │   ├── data/
│   │   │   ├── dao/officer_dao.dart
│   │   │   ├── entities/officer_entity.dart
│   │   │   ├── mappers/officer_mapper.dart
│   │   │   └── repositories/officer_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── models/officer.dart
│   │   │   ├── repositories/officer_repository.dart
│   │   │   └── services/officer_service.dart
│   │   └── presentation/
│   │       ├── screens/officers_list_screen.dart
│   │       ├── screens/officer_form_screen.dart   ← create + edit
│   │       ├── screens/officer_detail_screen.dart
│   │       └── widgets/officer_card.dart
│   └── dashboard/
│       └── presentation/screens/dashboard_screen.dart
├── routes/app_routes.dart
├── shared/
│   ├── components/
│   │   ├── cyber_button.dart
│   │   ├── cyber_card.dart
│   │   └── cyber_text_input.dart  ← inclui CyberDropdown
│   └── widgets/
│       ├── loading_overlay.dart
│       └── ncpd_app_bar.dart
└── main.dart
```

---

## 🔁 Replicar para Nova Feature

1. Copie a estrutura de `features/officers/`
2. Renomeie entidade, DAO, mapper, repositório, service, screens
3. Registre a entidade em `app_database.dart` → `@Database(entities: [...])`
4. Registre o DAO em `AppDatabase` como getter
5. Registre o repositório e service em `ServiceLocator`
6. Adicione migration se o schema mudou
7. Adicione rota em `AppRoutes`

---

## ⚡ Notas

- Senhas hasheadas com **SHA-256** (pacote `crypto`)
- `AuthRepositoryImpl` simula **2 segundos de latência** (NCPD network)
- `ServiceLocator` é DI manual — sem `provider`, `get_it` ou `riverpod`
- `SessionManager` guarda o oficial logado em memória

