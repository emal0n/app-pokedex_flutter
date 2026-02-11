# Pokedex App

[![Flutter](https://img.shields.io/badge/Flutter-3.11.0-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.11.0-0175C2.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Repository](https://img.shields.io/badge/Repository-GitHub-black.svg)](https://github.com/emal0n/app-pokedex_flutter)
[![Status](https://img.shields.io/badge/Status-Active-brightgreen.svg)](#)

## Status CI/CD

[![CI - Build and Test](https://github.com/emal0n/app-pokedex_flutter/workflows/CI%20-%20Build%20and%20Test/badge.svg)](https://github.com/emal0n/app-pokedex_flutter/actions)
[![Android Release](https://github.com/emal0n/app-pokedex_flutter/workflows/Android%20Release%20Build/badge.svg)](https://github.com/emal0n/app-pokedex_flutter/actions)
[![Code Quality](https://github.com/emal0n/app-pokedex_flutter/workflows/Code%20Quality%20&%20Security/badge.svg)](https://github.com/emal0n/app-pokedex_flutter/actions)

Um aplicativo Flutter elegante e interativo para explorar e descobrir informações sobre Pokémon usando a PokéAPI.

**Repositório GitHub:** [https://github.com/emal0n/app-pokedex_flutter](https://github.com/emal0n/app-pokedex_flutter)

---

## Recursos Principais

- Listagem completa de Pokémon com carregamento progressivo
- Visualização detalhada de informações do Pokémon
- Estatísticas visuais com barras de progresso coloridas
- Sistema de shimmer para estado de carregamento
- Pull-to-refresh para atualização de dados
- Interface responsiva e adaptativa para diferentes plataformas
- Dark mode por padrão
- Navegação fluida e intuitiva
- Acesso direto ao repositório GitHub

---

## Tecnologias Utilizadas

[![Technology Stack](https://img.shields.io/badge/Stack-Flutter%2FDart-informational)](#)

### Dependências Principais

- **flutter**: SDK Flutter
- **adaptive_platform_ui**: Interface adaptativa para diferentes plataformas
- **google_fonts**: Tipografia personalizada do Google Fonts
- **http**: Cliente HTTP para requisições à API
- **shimmer**: Efeito de carregamento shimmer
- **url_launcher**: Abertura de links externos

---

## Instalação e Setup

### Pré-requisitos

- Flutter 3.11.0 ou superior
- Dart 3.11.0 ou superior
- Git

### Passos para Instalação

1. Clone o repositório

```bash
git clone https://github.com/emal0n/app-pokedex_flutter.git
cd app-pokedex_flutter
```

2. Instale as dependências

```bash
flutter pub get
```

3. Execute a aplicação

```bash
flutter run
```

4. Compilar para produção (Android)

```bash
flutter build apk
```

5. Compilar para produção (iOS)

```bash
flutter build ios
```

---

## Estrutura do Projeto

```
app-pokedex_flutter/
├── lib/
│   ├── main.dart                    # Arquivo principal da aplicação
│   ├── models/
│   │   └── pokemon.dart            # Modelo de dados do Pokémon
│   ├── pages/
│   │   ├── home_page.dart          # Página inicial com lista de Pokémon
│   │   ├── pokemon_detail_page.dart # Página de detalhes do Pokémon
│   │   └── extras_page.dart        # Página de extras e informações
│   ├── services/
│   │   └── pokemon_service.dart    # Serviço de integração com PokéAPI
│   └── widgets/
│       ├── adaptive_bottom_nav_bar.dart # Navegação inferior adaptativa
│       ├── pokemon_card.dart           # Card individual do Pokémon
│       ├── shimmer_menu_card.dart      # Card com shimmer para menu
│       ├── shimmer_pokemon_card.dart   # Card com shimmer para Pokémon
│       └── shimmer_pokemon_detail.dart # Shimmer para página de detalhes
├── assets/                         # Recursos e imagens
├── pubspec.yaml                    # Dependências do projeto
└── README.md                       # Este arquivo
```

---

## Funcionalidades Detalhadas

### Home Page - Listagem de Pokémon

- Exibição em grid 2x2 de Pokémon
- Carregamento infinito ao scrollar
- Shimmer durante o carregamento inicial
- Pull-to-refresh para atualizar a lista
- Navegação para detalhes ao clicar em um Pokémon

### Pokemon Detail Page - Informações Detalhadas

- Imagem em alta definição
- Descrição e informações do Pokémon
- Estatísticas visuais com barras de progresso coloridas
- Visualização de Altura, Peso e Geração
- Design limpo e direto com informações essenciais

### Extras Page - Informações Adicionais

- Link para repositório GitHub
- Informações sobre a PokéAPI
- Documentação e recursos complementares

---

## API Utilizada

O projeto utiliza a [PokéAPI v2](https://pokeapi.co/) para obter os dados dos Pokémon.

**Características da API:**
- Sem autenticação necessária
- RESTful API completamente aberta
- Mais de 1025 Pokémon disponíveis
- Documentação completa em: https://pokeapi.co/docs/v2

---

## Configuração da Aplicação

### Cores e Tipografia

- **Tema**: Dark Mode (Fundo #1E1E1E)
- **Tipografia Principal**: Poppins (Google Fonts)
- **Tipografia Secundária**: Roboto (Google Fonts)
- **Cores por Tipo de Pokémon**: Paleta customizada para cada tipo

### Plataformas Suportadas

- Android 5.0+
- iOS 11.0+
- Web (em desenvolvimento)

---

## Desenvolvimento

### Estrutura de Código

O projeto segue uma arquitetura clean com separação de responsabilidades:

- **Models**: Estruturas de dados (Pokemon)
- **Services**: Lógica de negócio e integração com APIs (PokemonService)
- **Pages**: Telas principais da aplicação
- **Widgets**: Componentes reutilizáveis
- **Assets**: Recursos estáticos

### Padrões Utilizados

- Provider Pattern para gerenciamento de estado
- Repository Pattern para acesso a dados
- Widget Composition para componentes reutilizáveis
- Material Design 3

---

## CI/CD e Automação

Este projeto utiliza GitHub Actions para automação de build, testes e deploy.

### Workflows Configurados

#### 1. **CI - Build and Test**
- ✅ Executa em cada push e pull request
- 🔍 Verifica formatação e análise de código
- 🧪 Executa testes automatizados
- 📦 Gera APK de debug

#### 2. **Android Release Build**
- 📱 Gera APK e App Bundle de release
- 🎉 Cria releases automáticos no GitHub
- 📤 Disponibiliza artefatos para download

#### 3. **iOS Release Build**
- 🍎 Gera build iOS para distribuição
- 📦 Cria arquivo de build

#### 4. **Code Quality & Security**
- 🔍 Análise de qualidade de código
- 🔒 Verificação de segurança de dependências
- 📊 Relatórios de cobertura de testes

#### 5. **PR Checks**
- ✅ Validação automática de Pull Requests
- 💬 Comentários com resultados dos testes
- 📊 Relatório de tamanho do APK

#### 6. **Dependency Updates**
- 🔄 Atualização automática semanal de dependências
- 📝 Criação de PR automático com atualizações

### Como Criar um Release

```bash
# Atualizar version em pubspec.yaml para 1.0.1
# Commit e criar tag
git add pubspec.yaml
git commit -m "chore: bump version to 1.0.1"
git tag v1.0.1
git push origin main
git push origin v1.0.1
```

Os workflows irão automaticamente:
- Executar testes
- Gerar APK e App Bundle
- Criar release no GitHub com os arquivos

Para mais detalhes, veja [.github/workflows/README.md](.github/workflows/README.md)

---

## Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

---

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## Contato e Suporte

Para dúvidas, sugestões ou reportar bugs:

- Abra uma issue no [GitHub](https://github.com/emal0n/app-pokedex_flutter/issues)
- Entre em contato através do repositório

---

## Agradecimentos

- [Flutter Community](https://flutter.dev) pela framework incrível
- [PokéAPI](https://pokeapi.co/) pelos dados dos Pokémon
- [Google Fonts](https://fonts.google.com/) pelas fontes
- Comunidade Flutter por ferramentas e suporte

---