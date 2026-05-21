# Pokédex Flutter App 🎮

Aplicativo Flutter que consome a **PokéAPI** (https://pokeapi.co) para exibir uma lista completa de Pokémons com detalhes, busca e interface visual temática.

---

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK instalado (versão 3.0+)
- Dart SDK ≥ 3.0.0
- Dispositivo físico ou emulador configurado

### Passos

```bash
# 1. Instalar dependências
flutter pub get

# 2. Executar o app
flutter run
```

---

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                  # Ponto de entrada da aplicação
├── models/
│   └── pokemon.dart           # Modelos de dados (Pokemon, PokemonListItem)
├── services/
│   └── pokemon_service.dart   # Consumo da API com http + cache em memória
├── screens/
│   ├── home_screen.dart       # Tela principal com grid paginado
│   ├── detail_screen.dart     # Tela de detalhes com tabs
│   └── search_screen.dart     # Tela de busca por nome/ID
├── widgets/
│   ├── pokemon_card.dart      # Card customizado com shimmer loading
│   ├── type_badge.dart        # Badge de tipo com cor temática
│   └── stat_bar.dart          # Barra de status animada
└── theme/
    └── app_theme.dart         # Tema global + cores por tipo
```

---

## 📡 API Utilizada

**PokéAPI** — https://pokeapi.co

| Endpoint | Uso |
|---|---|
| `GET /api/v2/pokemon?limit=20&offset=0` | Lista paginada de Pokémons |
| `GET /api/v2/pokemon/{id}` | Detalhes completos por ID |
| `GET /api/v2/pokemon/{name}` | Busca por nome |

A biblioteca **`http`** é usada para todas as requisições HTTP, com `jsonDecode` para parsear o JSON.

---

## ✨ Funcionalidades

- 📜 **Lista infinita** — paginação automática ao rolar até o fim
- 🎨 **Cores temáticas** — cada Pokémon tem cor baseada no seu tipo
- 🔍 **Busca** — por nome (ex: "pikachu") ou número (ex: "25")
- 📊 **Stats animados** — barras de progresso com animação suave
- 🏃 **Hero animation** — transição de imagem entre telas
- 💀 **Shimmer loading** — skeleton enquanto carrega
- ⚡ **Cache em memória** — evita requisições repetidas
- 📱 **Design responsivo** — funciona em diferentes tamanhos de tela

---

## 📦 Dependências

```yaml
http: ^1.2.1                    # Requisições HTTP
cached_network_image: ^3.3.1    # Cache de imagens
google_fonts: ^6.2.1            # Tipografia (Poppins)
shimmer: ^3.0.0                 # Efeito shimmer no loading
```

---

## 🎓 Projeto Avaliativo — Flutter

Desenvolvido como projeto avaliativo da disciplina de Flutter.

| Critério | Implementação |
|---|---|
| Consumo de API | `PokemonService` com `http`, 3 endpoints |
| UI/Usabilidade | Grid responsivo, Hero animation, shimmer, tabs |
| Organização do código | Separação em models, services, screens, widgets, theme |
