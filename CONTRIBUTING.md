# Guia de Contribuição

Obrigado por considerar contribuir para o Pokedex Flutter App! 🎉

## 📋 Índice

- [Código de Conduta](#código-de-conduta)
- [Como Posso Contribuir?](#como-posso-contribuir)
- [Processo de Desenvolvimento](#processo-de-desenvolvimento)
- [Padrões de Código](#padrões-de-código)
- [Processo de Pull Request](#processo-de-pull-request)
- [Reportar Bugs](#reportar-bugs)
- [Sugerir Melhorias](#sugerir-melhorias)

---

## Código de Conduta

Este projeto adere a um código de conduta. Ao participar, espera-se que você mantenha este código.

---

## Como Posso Contribuir?

### 🐛 Reportar Bugs

Bugs são rastreados como [GitHub Issues](https://github.com/emal0n/app-pokedex_flutter/issues). 

Antes de criar um bug report:
- Verifique se o bug já não foi reportado
- Determine qual repositório o problema pertence
- Colete informações sobre o bug

Ao criar um bug report, inclua:
- **Título claro e descritivo**
- **Passos para reproduzir** o problema
- **Comportamento esperado** vs **comportamento atual**
- **Screenshots** se aplicável
- **Ambiente** (versão do Flutter, dispositivo, OS)

Exemplo:
```markdown
**Descrição**
O app trava ao tentar carregar detalhes de um Pokémon específico.

**Passos para reproduzir**
1. Abrir o app
2. Clicar no Pokémon #150 (Mewtwo)
3. Aguardar carregamento

**Comportamento esperado**
Deveria mostrar os detalhes do Pokémon.

**Comportamento atual**
App trava e fecha.

**Ambiente**
- Flutter: 3.11.0
- Dispositivo: Samsung Galaxy S21
- Android: 13
```

---

### 💡 Sugerir Melhorias

Sugestões de melhorias também são rastreadas como [GitHub Issues](https://github.com/emal0n/app-pokedex_flutter/issues).

Ao criar uma sugestão, inclua:
- **Título claro e descritivo**
- **Descrição detalhada** da melhoria sugerida
- **Explicação** de por que essa melhoria seria útil
- **Exemplos** de implementação se possível

---

### 🔧 Contribuir com Código

1. **Fork** o repositório
2. **Clone** seu fork
   ```bash
   git clone https://github.com/seu-usuario/app-pokedex_flutter.git
   cd app-pokedex_flutter
   ```

3. **Configure** o upstream
   ```bash
   git remote add upstream https://github.com/emal0n/app-pokedex_flutter.git
   ```

4. **Crie uma branch** para sua feature
   ```bash
   git checkout -b feature/minha-feature
   ```

5. **Faça suas alterações** e commits
   ```bash
   git add .
   git commit -m "feat: adiciona nova funcionalidade"
   ```

6. **Push** para seu fork
   ```bash
   git push origin feature/minha-feature
   ```

7. **Abra um Pull Request**

---

## Processo de Desenvolvimento

### Setup do Ambiente

1. **Pré-requisitos**
   - Flutter 3.11.0+
   - Dart 3.11.0+
   - Android Studio / VS Code
   - Git

2. **Instalar dependências**
   ```bash
   flutter pub get
   ```

3. **Executar o app**
   ```bash
   flutter run
   ```

4. **Executar testes**
   ```bash
   flutter test
   ```

### Workflow de Desenvolvimento

1. **Antes de começar**
   - Sincronize com o repositório upstream
     ```bash
     git fetch upstream
     git checkout main
     git merge upstream/main
     ```

2. **Durante o desenvolvimento**
   - Faça commits pequenos e frequentes
   - Use mensagens de commit descritivas
   - Mantenha o código formatado
     ```bash
     dart format .
     ```
   - Execute análise de código
     ```bash
     flutter analyze
     ```

3. **Antes de fazer push**
   - Execute todos os testes
     ```bash
     flutter test
     ```
   - Verifique formatação
     ```bash
     dart format --output=none --set-exit-if-changed .
     ```
   - Verifique análise
     ```bash
     flutter analyze
     ```

---

## Padrões de Código

### Estilo de Código

- Siga o [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `dart format` para formatação automática
- Mantenha linhas com no máximo 80-100 caracteres

### Convenções de Nomenclatura

- **Classes**: PascalCase
  ```dart
  class PokemonCard extends StatelessWidget
  ```

- **Variáveis e Funções**: camelCase
  ```dart
  String pokemonName;
  void fetchPokemonData()
  ```

- **Constantes**: lowerCamelCase com `const` ou `final`
  ```dart
  const int maxPokemonCount = 1025;
  ```

- **Arquivos**: snake_case
  ```
  pokemon_detail_page.dart
  ```

### Estrutura de Arquivos

```
lib/
├── models/           # Modelos de dados
├── pages/            # Telas/Páginas
├── services/         # Serviços e APIs
├── widgets/          # Widgets reutilizáveis
└── main.dart         # Ponto de entrada
```

### Comentários e Documentação

```dart
/// Representa um Pokémon com suas informações básicas.
///
/// Esta classe contém os dados principais de um Pokémon,
/// incluindo nome, ID, tipos e estatísticas.
class Pokemon {
  /// O nome do Pokémon.
  final String name;
  
  /// O ID único do Pokémon.
  final int id;
  
  // ...
}
```

---

## Processo de Pull Request

### Antes de Submeter

- [ ] Código está formatado (`dart format .`)
- [ ] Análise não apresenta erros (`flutter analyze`)
- [ ] Todos os testes passam (`flutter test`)
- [ ] Código segue os padrões do projeto
- [ ] Commits seguem convenção de mensagens
- [ ] Branch está atualizada com `main`

### Template de Pull Request

```markdown
## Descrição
Breve descrição das mudanças.

## Tipo de Mudança
- [ ] Bug fix (mudança que corrige um problema)
- [ ] Nova feature (mudança que adiciona funcionalidade)
- [ ] Breaking change (mudança que quebra compatibilidade)
- [ ] Documentação

## Como Testar
1. Passo 1
2. Passo 2
3. Passo 3

## Screenshots (se aplicável)
Adicione screenshots mostrando as mudanças.

## Checklist
- [ ] Código está formatado
- [ ] Testes passam
- [ ] Documentação atualizada
- [ ] Sem warnings de análise
```

### Revisão

- PRs serão revisados por mantenedores
- Pode haver solicitação de mudanças
- CI/CD deve passar (testes, formatação, build)
- Pelo menos 1 aprovação necessária

---

## Convenções de Commit

Use [Conventional Commits](https://www.conventionalcommits.org/):

### Formato
```
<tipo>(<escopo>): <descrição>

[corpo opcional]

[rodapé opcional]
```

### Tipos

- `feat`: Nova feature
- `fix`: Correção de bug
- `docs`: Mudanças em documentação
- `style`: Formatação, ponto e vírgula, etc
- `refactor`: Refatoração de código
- `test`: Adição ou correção de testes
- `chore`: Manutenção, dependências, etc
- `perf`: Melhorias de performance
- `ci`: Mudanças em CI/CD

### Exemplos

```bash
# Feature
git commit -m "feat(pokemon): adiciona filtro por tipo"

# Bug fix
git commit -m "fix(detail): corrige crash ao carregar stats"

# Documentação
git commit -m "docs: atualiza README com instruções de setup"

# Chore
git commit -m "chore(deps): atualiza dependência http para 1.2.0"

# Breaking change
git commit -m "feat(api)!: muda estrutura do modelo Pokemon

BREAKING CHANGE: campo 'type' agora é 'types' (array)"
```

---

## Testes

### Executar Testes

```bash
# Todos os testes
flutter test

# Testes específicos
flutter test test/models/pokemon_test.dart

# Com cobertura
flutter test --coverage
```

### Escrever Testes

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/models/pokemon.dart';

void main() {
  group('Pokemon', () {
    test('deve criar Pokemon a partir de JSON', () {
      final json = {
        'id': 1,
        'name': 'bulbasaur',
        'types': ['grass', 'poison'],
      };
      
      final pokemon = Pokemon.fromJson(json);
      
      expect(pokemon.id, 1);
      expect(pokemon.name, 'bulbasaur');
      expect(pokemon.types.length, 2);
    });
  });
}
```

---

## Recursos Úteis

### Documentação
- [Flutter Docs](https://docs.flutter.dev/)
- [Dart Docs](https://dart.dev/guides)
- [PokéAPI](https://pokeapi.co/docs/v2)

### Ferramentas
- [Flutter DevTools](https://docs.flutter.dev/development/tools/devtools/overview)
- [VS Code Flutter Extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [Android Studio Flutter Plugin](https://plugins.jetbrains.com/plugin/9212-flutter)

### Comunidade
- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

---

## Dúvidas?

Se tiver dúvidas sobre o processo de contribuição:

1. Verifique a [documentação](README.md)
2. Procure em [issues existentes](https://github.com/emal0n/app-pokedex_flutter/issues)
3. Abra uma [nova issue](https://github.com/emal0n/app-pokedex_flutter/issues/new)

---

**Obrigado por contribuir! 🚀**

