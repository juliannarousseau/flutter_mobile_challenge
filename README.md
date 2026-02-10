
# 📱 Flutter Mobile Challenge  
## App Mobile com API Pública, Notificações e Autenticação  

### 📌 Contexto

Este projeto simula um **desafio técnico real de entrevista mobile**, inspirado em testes comuns de mercado para Flutter.

O objetivo é desenvolver um aplicativo Flutter do zero, demonstrando **domínio de arquitetura limpa**, separação de responsabilidades, gerenciamento de estado previsível e boas práticas modernas.

O foco **não é UI sofisticada**, mas sim **estrutura, clareza arquitetural e raciocínio técnico**.

---

###  🎯 Objetivo do Desafio

Construir um aplicativo Flutter que:

- Consuma uma **API pública REST**
- Utilize **roteamento declarativo**
- Gerencie estados de forma previsível
- Faça **injeção de dependência desacoplada**
- Integre **notificações locais**
- Possua **autenticação e cadastro de usuário com Firebase**

---

###  ✅ Stack Técnica Obrigatória

- Flutter **3.x** com **Null Safety**
- Android e iOS habilitados
- **go_router** → navegação
- **Bloc** → gerenciamento de estado
- **get_it** → injeção de dependência
- **flutter_local_notifications** → notificações locais
- **Firebase Auth** (Email/Senha + Google)
- **Firebase Database ou Firestore**
- Organização em **Clean Architecture**
- README.md explicativo

---

###  🧩 Funcionalidades Obrigatórias

#### 1️⃣ Consumo de API Pública

Utilize a API:

[https://jsonplaceholder.typicode.com/](https://jsonplaceholder.typicode.com/)


Requisitos:

- Criar **Services/Datasources** para consumo da API
- Criar **Models** para parse JSON → Model
- Converter Model → Entity
- Exibir os dados em tela
- Estado controlado via **Bloc**
- UI apenas reage ao estado (sem lógica de negócio)

Exemplo de recursos:
- Posts
- Users
- Albums
- Comments

---

### 2️⃣ Notificações Locais

Implementar notificações locais utilizando `flutter_local_notifications`.

Exemplos válidos:
- Notificar quando novos dados da API forem carregados
- Notificação agendada após N segundos
- Notificação disparada por ação do usuário

A lógica de disparo **não deve estar na View**.

---

### 3️⃣ Firebase + Autenticação

Implementar autenticação com:

- Email e senha
- Login social com Google

Fluxo obrigatório:
- Login
- Cadastro de usuário
- Logout

---

### 4️⃣ Cadastro de Usuário

Criar fluxo de cadastro contendo:

- Nome
- Telefone (com máscara)
- CPF (com máscara)
- Data de nascimento

Regras:
- Validações fora da UI
- Dados persistidos no **Firebase Database / Firestore**
- Entidade de domínio independente do Firebase

---

### 🧱 Regras de Arquitetura

- Nenhuma regra de negócio na UI
- Sem métodos que retornam widgets (!!)
- Bloc apenas orquestra estados
- UseCases concentram regras
- Repositórios são contratos
- Implementações ficam na camada data
- Firebase, HTTP, plugins = **detalhes**, nunca domínio

---

### 🏗️ Arquitetura do Projeto
```
lib/
│
├── core/
│   ├── router/
│   │   └── app_router.dart          // go_router
│   ├── di/
│   │   └── injection.dart           // get_it
│   ├── notifications/
│   │   └── local_notification_service.dart
│   └── utils/
│
├── features/
│   ├── auth/
│   │   ├── presentation/
│   │   │   ├── bloc/
│   │   │   │   ├── auth_bloc.dart
│   │   │   │   ├── auth_event.dart
│   │   │   │   └── auth_state.dart
│   │   │   ├── pages/
│   │   │   │   ├── login_page.dart
│   │   │   │   └── register_page.dart
│   │   │   └── widgets/
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login_usecase.dart
│   │   │       └── register_user_usecase.dart
│   │   │
│   │   └── data/
│   │       ├── models/
│   │       │   └── user_model.dart
│   │       ├── datasources/
│   │       │   ├── auth_remote_datasource.dart
│   │       │   └── auth_firebase_datasource.dart
│   │       └── repositories/
│   │           └── auth_repository_impl.dart
│   │
│   ├── posts/
│   │   ├── presentation/
│   │   │   ├── bloc/
│   │   │   │   ├── posts_bloc.dart
│   │   │   │   ├── posts_event.dart
│   │   │   │   └── posts_state.dart
│   │   │   ├── pages/
│   │   │   │   ├── posts_page.dart
│   │   │   │   └── post_detail_page.dart
│   │   │   └── widgets/
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── post_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── posts_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_posts_usecase.dart
│   │   │
│   │   └── data/
│   │       ├── models/
│   │       │   └── post_model.dart
│   │       ├── datasources/
│   │       │   └── posts_remote_datasource.dart
│   │       └── repositories/
│   │           └── posts_repository_impl.dart
│
└── main.dart

```
---

### 🔄 Fluxo de Dados

1. UI dispara um evento
2. Bloc recebe o evento
3. Bloc chama o UseCase
4. UseCase executa a regra de negócio
5. Repositório decide a fonte de dados
6. Datasource externo (API / Firebase)
7. Entidade retorna ao domínio
8. Bloc emite um novo estado
9. UI reage ao estado

---

###  🧪 Estratégia de Testes

Foco principal em **testes unitários**:

- UseCases
- Regras de negócio
- Repositórios
- Conversão Model ↔ Entity

UI tests são opcionais.

---

###  🔗 Deep Linking (Opcional)

Implementar deep link com `go_router`.

Exemplo:

```

seuapp://posts/10

```

Requisitos:
- Navegação direta para tela de detalhe
- Parâmetros tratados fora da View
- Rota declarativa

---

### 🎙️ Áudio + Firebase Storage (Opcional)

- Gravação de áudio
- Player
- Opção de salvar no Firebase Storage
- Upload desacoplado da UI

---

### 🚀 Possíveis Extensões

- Cache local
- Offline-first
- Paginação
- Feature flags
- Analytics
- Dark mode
- Testes de integração
