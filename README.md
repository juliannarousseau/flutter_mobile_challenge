# 📱 Desafio Técnico — Flutter Mobile Engineer
### Nível Pleno · Clean Architecture · 7 dias

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter)
![Bloc](https://img.shields.io/badge/Bloc-State_Management-orange?style=flat)
![Firebase](https://img.shields.io/badge/Firebase-Auth_+_Firestore-FFCA28?style=flat&logo=firebase)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean-green?style=flat)

---

## 🏢 Contexto do Produto

Você foi contratado como engenheiro mobile pleno em uma startup de conteúdo que agrega artigos de diferentes fontes. O produto principal é um **feed de posts** onde usuários autenticados podem navegar, consultar o perfil do autor de cada artigo e salvar favoritos.

> **Objetivo:** Entregar as 3 telas principais do app (Feed, Detalhe do Post e Perfil do Autor), consumindo a API pública JSONPlaceholder, com arquitetura limpa, gerenciamento de estado via Bloc e autenticação via Firebase.
>
> O foco da avaliação é **estrutura, coesão arquitetural e raciocínio técnico** — não sofisticação visual.

---

## 📡 Contrato de API

A aplicação consome dois endpoints da [JSONPlaceholder](https://jsonplaceholder.typicode.com/).

### `GET /posts`
```json
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum..."
  }
]
```

### `GET /users/:id`
```json
{
  "id": 1,
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874"
  },
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net"
  }
}
```

---

## ✅ Funcionalidades Obrigatórias

### Feature 1 — Feed de Posts
Tela principal da aplicação, acessível apenas por usuários autenticados.

**Regras de negócio:**
- Exibir lista de posts consumidos de `GET /posts`
- Cada item mostra: título, preview do body (máx. 100 caracteres) e nome do autor (resolvido via `GET /users/:id` usando o `userId` do post)
- Exibir estado de **loading** enquanto dados são carregados
- Exibir estado de **erro com retry** em caso de falha na requisição
- Ao tocar em um post, navegar para a tela de Detalhe

> ✔️ **Critério de aceite:** A UI reage exclusivamente aos estados emitidos pelo `PostsBloc`. Nenhuma chamada de API ou regra de negócio pode estar na camada de apresentação.

---

### Feature 2 — Detalhe do Post
Tela de leitura completa de um post, com acesso ao perfil do autor.

**Regras de negócio:**
- Exibir o post completo (título e body sem truncamento)
- Exibir nome e e-mail do autor
- Botão **"Ver perfil do autor"** navega para a tela de Perfil
- Botão **"Salvar"** persiste o post nos favoritos do usuário logado no Firestore
- Se o post já está nos favoritos, exibir estado "Salvo" (toggle)

> ✔️ **Critério de aceite:** A lógica de favoritar/desfavoritar é encapsulada num `UseCase`. O Bloc recebe o evento e emite `PostSaved` ou `PostUnsaved` sem que a View saiba de onde vêm os dados.

---

### Feature 3 — Perfil do Autor
Tela de exibição dos dados públicos do autor de um post.

**Dados a exibir:**
- Nome completo e username
- E-mail e telefone
- Endereço completo (street, suite, city, zipcode)
- Website e catchPhrase da empresa

> ✔️ **Critério de aceite:** Os dados do autor são mapeados de `UserModel` para `UserEntity` antes de chegar na UI. Nenhum campo do modelo de rede pode aparecer diretamente em widgets.

---

### Feature 4 — Autenticação
Fluxo completo de autenticação com Firebase Auth.

**Telas e fluxos:**
- Login com e-mail e senha
- Login social com Google Sign-In
- Cadastro com e-mail e senha
- Logout acessível a partir da tela de Feed

**Regras:**
- Usuário não autenticado deve ser redirecionado para Login (guard no `go_router`)
- Após autenticação bem-sucedida, redirecionar para Feed
- Erros de autenticação devem ser exibidos na UI via estado do `AuthBloc`

---

## 🏗️ Arquitetura Exigida

O projeto deve seguir **Clean Architecture** com separação em 3 camadas por feature.

```
lib/
├── core/
│   ├── router/
│   │   └── app_router.dart                   # go_router + route guards
│   ├── di/
│   │   └── injection.dart                    # get_it registrations
│   ├── notifications/
│   │   └── local_notification_service.dart
│   └── utils/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/user_model.dart
│   │   │   ├── datasources/auth_firebase_datasource.dart
│   │   │   └── repositories/auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/user_entity.dart
│   │   │   ├── repositories/auth_repository.dart        # interface
│   │   │   └── usecases/
│   │   │       ├── sign_in_usecase.dart
│   │   │       ├── sign_up_usecase.dart
│   │   │       └── sign_out_usecase.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       └── pages/
│   │           ├── login_page.dart
│   │           └── register_page.dart
│   │
│   └── posts/
│       ├── data/
│       │   ├── models/
│       │   │   ├── post_model.dart
│       │   │   └── user_model.dart
│       │   ├── datasources/
│       │   │   └── posts_remote_datasource.dart
│       │   └── repositories/
│       │       └── posts_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── post_entity.dart
│       │   │   └── user_entity.dart
│       │   ├── repositories/
│       │   │   └── posts_repository.dart               # interface
│       │   └── usecases/
│       │       ├── get_posts_usecase.dart
│       │       ├── get_user_usecase.dart
│       │       ├── save_post_usecase.dart
│       │       └── get_saved_posts_usecase.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── posts_bloc.dart
│           │   ├── posts_event.dart
│           │   └── posts_state.dart
│           └── pages/
│               ├── feed_page.dart
│               ├── post_detail_page.dart
│               └── author_profile_page.dart
│
└── main.dart
```

### Regras de Arquitetura (non-negotiable)

| Camada | O que pode conter |
|---|---|
| **Domain** | Entities, UseCases, contratos de Repository. Zero dependência de Flutter ou pacotes externos. |
| **Data** | Models, Datasources, implementações de Repository. Conhece HTTP e Firebase. Converte Model → Entity. |
| **Presentation** | Bloc (apenas orquestra estados), Pages e Widgets. Nunca chama datasource diretamente. Nunca tem lógica de negócio. |

> 🚫 **Proibido:** métodos que retornam Widgets · `BuildContext` fora da apresentação · lógica de negócio em `initState`, `build` ou callbacks da UI · instanciar `Repository` ou `Datasource` diretamente na View.

---

## 🔄 Fluxo de Dados Esperado

Todo ciclo de dados deve seguir o fluxo abaixo sem atalhos:

```
1. UI dispara um PostEvent (ex: LoadPostsRequested)
       ↓
2. PostsBloc recebe o evento e chama o UseCase correspondente
       ↓
3. UseCase executa a regra de negócio e consulta o Repository via interface
       ↓
4. PostsRepositoryImpl decide a fonte de dados (API remota ou cache)
       ↓
5. PostsRemoteDatasource realiza a chamada HTTP e retorna PostModel
       ↓
6. Repository converte PostModel → PostEntity e retorna ao UseCase
       ↓
7. PostsBloc emite PostsLoaded(posts) ou PostsError(message)
       ↓
8. FeedPage.build() reage ao estado e renderiza a lista ou o erro
```

---

## 🔔 Notificações Locais

Integre `flutter_local_notifications` seguindo as regras abaixo:

- Disparar notificação ao concluir o carregamento dos posts (ex: *"25 posts carregados"*)
- Disparar notificação ao salvar um post nos favoritos (ex: *"Post salvo nos seus favoritos"*)
- A lógica de disparo deve estar em `LocalNotificationService`, injetado via `get_it`
- O Bloc chama o service — a View **nunca** dispara notificações diretamente

> 💡 Encapsule o `LocalNotificationService` atrás de uma interface para facilitar mock em testes.

---

## 🧪 Testes Unitários

Escreva testes unitários para os seguintes pontos — são **obrigatórios** para avaliação:

- `GetPostsUseCase` — deve retornar lista de `PostEntity` ao chamar o repository
- `GetPostsUseCase` — deve propagar exceção quando o repository falha
- `SavePostUseCase` — deve chamar o método correto do repository com a entity correta
- `PostModel.fromJson` — deve converter JSON corretamente para `PostModel`
- `PostModel.toEntity` — deve mapear todos os campos de `PostModel` para `PostEntity`
- `PostsBloc` — deve emitir `[PostsLoading, PostsLoaded]` ao receber `LoadPostsRequested`
- `PostsBloc` — deve emitir `[PostsLoading, PostsError]` quando `GetPostsUseCase` lança exceção

> Use `mocktail` ou `mockito` para mockar dependências. Nenhum teste deve acessar a internet ou o Firebase real.

---

## 📊 Critérios de Avaliação

| Critério | Descrição | Peso |
|---|---|:---:|
| **Arquitetura** | Separação correta das camadas, inversão de dependência, contratos via interface | 30% |
| **Bloc / Estado** | Estados bem definidos, eventos corretos, nenhuma lógica na UI | 25% |
| **Qualidade do código** | Nomenclatura, coesão, ausência de acoplamentos indevidos, SOLID | 20% |
| **Testes unitários** | Cobertura dos UseCases, Bloc e conversão de modelos | 15% |
| **Funcionalidade** | App compilando e todas as features funcionando conforme especificado | 10% |

---

## 📦 Stack Técnica

| Tecnologia | Versão/Pacote | Finalidade |
|---|---|---|
| Flutter | 3.x + Null Safety | Framework principal |
| Bloc | `flutter_bloc ^8` | Gerenciamento de estado |
| go_router | `^13` | Roteamento declarativo + guards |
| get_it | `^7` | Injeção de dependência |
| firebase_auth | latest | Autenticação |
| cloud_firestore | latest | Persistência de favoritos |
| flutter_local_notifications | `^17` | Notificações locais |
| http ou dio | latest | Client HTTP |
| mocktail | latest | Mocks em testes unitários |

---

## 🚀 Entrega

| Item | Requisito |
|---|---|
| **Prazo** | 7 dias corridos a partir do recebimento deste documento |
| **Repositório** | GitHub público ou privado (adicionar revisor conforme instruído) |
| **README** | Instruções de como rodar, decisões de arquitetura, trade-offs e possíveis melhorias |
| **Firebase** | `google-services.json` / `GoogleService-Info.plist` **não** deve ser commitado |
| **Compilação** | O app deve compilar e rodar sem erros em modo debug no Android ou iOS |

> 💡 **Dica final:** Documente no README as decisões que você tomou e por quê. Um engenheiro pleno que sabe explicar as próprias escolhas vale mais do que um código sem contexto.

---

*Dúvidas sobre o desafio? Entre em contato com o time de engenharia.*