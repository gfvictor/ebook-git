\newpage

# Capítulo V
\vspace{-1em}
## Os Guardiões Automáticos - Git Hooks
\vspace{1em}

Confiar que todo desenvolvedor do time vai lembrar de rodar o linter, formatar o código e passar os testes antes de cada
commit é o mesmo que confiar que todo mundo vai lavar a louça sem ninguém mandar. Não vai acontecer. O que você precisa
é de um porteiro automático que barre o código ruim antes que ele entre.

### 5.1 O que São Hooks

Hooks são scripts que o Git executa automaticamente quando certos eventos acontecem: antes de um commit, depois de um
merge, antes de um push. Eles moram na pasta `.git/hooks/` do seu repositório.

Dá uma olhada no que já vem lá:

```bash
$ ls .git/hooks/
pre-commit.sample  commit-msg.sample  pre-push.sample  ...
```

Todo repositório nasce com exemplos. Eles terminam em `.sample` justamente para **não** rodarem. Para ativar um hook,
você cria um arquivo com o nome exato (sem o `.sample`), coloca um script dentro e dá permissão de execução:

```bash
$ chmod +x .git/hooks/pre-commit
```

O script pode ser em shell, Python, Node, o que você quiser, desde que seja executável. Se ele terminar com um código de
saída diferente de zero, o Git **aborta** a operação.

### 5.2 Client-side vs. Server-side

- **Client-side hooks:** rodam na máquina do desenvolvedor (`pre-commit`, `commit-msg`, `pre-push`). Servem para pegar
  problema cedo, antes de virar commit;
- **Server-side hooks:** rodam no servidor Git quando um push chega (`pre-receive`, `update`, `post-receive`). Servem
  para impor política de forma inescapável.

Em fluxos modernos com GitHub ou GitLab, o papel dos server-side hooks é feito por **CI e branch protection rules** (o
assunto do próximo capítulo). Então, aqui, o foco são os client-side.

### 5.3 Os Hooks que Importam no Dia a Dia

- **`pre-commit`**: roda antes de o commit ser criado. Lugar do linter, do formatador, e de checar se não sobrou um
  `console.log`, um `debugger` ou um `TODO: arrumar isso depois`;
- **`commit-msg`**: recebe o arquivo com a mensagem de commit. Lugar de validar que ela segue o padrão (Conventional
  Commits, por exemplo);
- **`pre-push`**: roda antes de o push sair. Lugar da suíte de testes completa, porque quebrar o build dos outros é
  feio.

### 5.4 Escrevendo um `pre-commit` na Mão

Um exemplo simples que barra qualquer commit contendo a marca `NAOCOMITAR` nos arquivos em stage:

```bash
#!/bin/sh

if git diff --cached --name-only | xargs grep -l "NAOCOMITAR" 2>/dev/null; then
  echo "Bloqueado: existe um 'NAOCOMITAR' no codigo em stage."
  exit 1
fi

exit 0
```

Salve como `.git/hooks/pre-commit`, dê `chmod +x`, e pronto. Da próxima vez que você tentar commitar aquele trecho de
debug que jurou que ia remover, o Git te impede.

### 5.5 O Problema: Hooks Não São Versionados

A pasta `.git/` inteira fica de fora do controle de versão. Isso significa que o seu lindo `pre-commit` existe **só na
sua máquina**. Nenhum colega recebe ele ao clonar o repositório. Cada pessoa teria que instalar os hooks na mão, toda
vez. Ninguém faz isso.

### 5.6 A Solução Moderna: Hooks Versionados

O truque é guardar os hooks numa pasta que **entra** no repositório (por convenção, `.githooks/`) e apontar o Git para
ela:

```bash
$ git config core.hooksPath .githooks
```

Agora os scripts são versionados, revisados em Pull Request e compartilhados com o time. Só falta rodar aquele `git
config` uma vez por clone — e é aí que entram as ferramentas que automatizam esse passo:

- **Husky:** o padrão no ecossistema Node. Um `npm install` já configura o `core.hooksPath` via script `prepare`.
  Configuração na pasta `.husky/`;
- **Lefthook:** escrito em Go, rápido, agnóstico de linguagem, configuração única em `lefthook.yml`, roda tarefas em
  paralelo;
- **pre-commit:** framework em Python, muito usado fora do mundo JavaScript, configuração em `.pre-commit-config.yaml`,
  com um catálogo enorme de hooks prontos.

Um `lefthook.yml` típico:

```yaml
pre-commit:
  parallel: true
  commands:
    lint:
      run: npx eslint {staged_files}
    format:
      run: npx prettier --check {staged_files}

commit-msg:
  commands:
    conventional:
      run: npx commitlint --edit {1}
```

### 5.6.1 `lint-staged`: Só o que Mudou

Rodar o linter no projeto inteiro a cada commit é lento e te faz querer desistir da vida. O `lint-staged` roda as
ferramentas **apenas nos arquivos que estão em stage**:

```json
{
  "lint-staged": {
    "*.{ts,tsx}": ["eslint --fix", "prettier --write"]
  }
}
```

Commit rápido, feedback imediato, sem passar raiva.

### 5.7 A Porta dos Fundos: `--no-verify`

Todo hook client-side pode ser ignorado:

```bash
$ git commit -m "eu sei o que estou fazendo" --no-verify
```

Isso pula o `pre-commit` e o `commit-msg`. Existe para emergências reais — um hotfix às 3h da manhã com o servidor no
chão. Se você usa isso no dia a dia, você não desativou um hook, você desativou o seu profissionalismo.

E lembre-se: o CI do próximo capítulo **não tem** `--no-verify`. Lá, não existe escapatória.
