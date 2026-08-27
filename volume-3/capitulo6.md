\newpage

# Capítulo VI
\vspace{-1em}
## A Linha de Montagem - CI/CD com GitHub Actions
\vspace{1em}

Os hooks do capítulo anterior são a primeira linha de defesa, mas rodam na máquina de quem commita, e já vimos que dá
para desligá-los com uma flag. A segunda linha é o **CI**: um robô que roda no servidor, numa máquina limpa, sem
`--no-verify`, sem "na minha máquina funciona", e que trava o merge se alguma coisa estiver errada.

### 6.1 CI e CD: os Termos

- **CI (Integração Contínua):** toda vez que alguém envia código, uma máquina limpa baixa o projeto, instala tudo do
  zero e roda lint, testes e build. Se algo falha, o time sabe em minutos, não em produção;
- **CD (Entrega ou Implantação Contínua):** se o CI passou e o código entrou na `main`, outra automação empacota e
  publica, seja num ambiente de homologação (entrega), seja direto em produção (implantação).

### 6.2 Anatomia de um Workflow

No GitHub, a automação vive em arquivos YAML dentro de `.github/workflows/`. Um exemplo mínimo, `.github/workflows/ci.yml`:

```yaml
name: CI

on:
  push:
    branches: [main]
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm

      - run: npm ci
      - run: npm run lint
      - run: npm test
      - run: npm run build
```

Traduzindo:

- **`on`**: os gatilhos. Aqui, todo push na `main` e todo Pull Request;
- **`jobs`**: os trabalhos. Cada um roda numa máquina virtual isolada;
- **`runs-on`**: qual sistema operacional. O `ubuntu-latest` é o mais rápido e barato;
- **`steps`**: os passos, em ordem. O `uses` chama uma ação pronta da comunidade; o `run` executa um comando de shell.

### 6.3 O Pipeline Rodando no Pull Request

Com o `pull_request` no gatilho, cada PR mostra o resultado do CI ali na tela: um sinal verde ou um sinal vermelho, com
o log completo de onde quebrou. Ninguém precisa clonar a branch do colega para descobrir que os testes não passam.

Mas mostrar o resultado não impede o merge. Para isso serve o **branch protection rule** (em *Settings -> Branches*):

- Exigir que o status check do CI passe antes do merge;
- Exigir pelo menos uma aprovação de revisão;
- Proibir push direto na `main`.

Agora sim: código quebrado **não entra**, não importa quem mandou.

### 6.4 Matrix: Testar em Vários Ambientes

A sua biblioteca precisa funcionar no Node 18, 20 e 22? Não escreva três jobs. Use uma matrix:

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node: [18, 20, 22]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
      - run: npm ci
      - run: npm test
```

O GitHub roda as três versões em paralelo.

### 6.5 Cache: Não Baixe a Internet Toda Vez

Instalar dependências do zero em toda execução é lento. O `cache: npm` no `setup-node` já resolve o caso mais comum,
guardando a pasta `~/.npm` entre execuções. Para situações manuais existe a ação `actions/cache`, mas, na maioria dos
projetos Node, o atalho do `setup-node` basta.

### 6.6 Tags, Releases e Versionamento Semântico

Quando o código está estável e você quer marcar "esta é a versão 1.4.0", você usa uma **tag**. Diferente de uma branch,
a tag não anda: ela crava um ponto fixo no histórico.

```bash
$ git tag -a v1.4.0 -m "release: primeira versao estavel do modulo de pagamento"
$ git push origin v1.4.0
```

O `-a` cria uma *annotated tag*, com autor, data e mensagem — use sempre essa. Para enviar todas as tags de uma vez:
`git push --tags`.

### 6.6.1 Versionamento Semântico (SemVer)

O padrão `MAJOR.MINOR.PATCH`:

- **PATCH** (`1.4.0` -> `1.4.1`): correção de bug, sem quebrar nada;
- **MINOR** (`1.4.1` -> `1.5.0`): funcionalidade nova, compatível com o que já existia;
- **MAJOR** (`1.5.0` -> `2.0.0`): mudança que quebra compatibilidade. Quem atualizar vai precisar mexer no código.

### 6.6.2 Release Automático

Uma tag empurrada para o servidor pode disparar o seu próprio workflow:

```yaml
on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: gh release create ${{ github.ref_name }} --generate-notes
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

O `--generate-notes` monta o changelog sozinho, a partir dos PRs mergeados desde a última tag. Pelo terminal, o mesmo se
faz com `gh release create v1.4.0 --generate-notes`.

### 6.7 Secrets e Deploy

Senhas, tokens e chaves de API **nunca** entram no YAML. Eles ficam em *Settings -> Secrets and variables -> Actions* e
são lidos via `${{ secrets.NOME }}`. Um job de deploy costuma ser um job extra com `needs: build` (só roda se o build
passou) e um `if` para rodar apenas na `main`:

```yaml
deploy:
  needs: build
  if: github.ref == 'refs/heads/main'
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - run: ./deploy.sh
      env:
        DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
```

### 6.8 O Ciclo Completo

Junte tudo o que os três volumes ensinaram e o fluxo profissional fica assim:

1. Você cria uma branch, trabalha, e limpa o histórico com `rebase -i` (Volume III, Capítulo I);
2. Abre o Pull Request (Volume II, Capítulo VI);
3. Os hooks locais já barraram o óbvio antes do push (Capítulo V);
4. O CI roda lint, testes e build numa máquina limpa (este capítulo);
5. Um colega revisa; o branch protection exige o sinal verde;
6. Merge na `main`. O CD publica. Uma tag marca a versão.

Nenhuma dessas etapas depende de alguém "lembrar" de fazer. É exatamente isso que separa um projeto de hobby de um
produto de engenharia.
