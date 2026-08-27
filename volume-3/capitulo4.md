\newpage

# Capítulo IV
\vspace{-1em}
## Gerenciamento de Contexto - Stash e Worktree
\vspace{1em}

O Slack apita. Bug crítico em produção, e adivinha quem foi escalado para apagar o incêndio? Você. O problema é que a
sua árvore de trabalho está uma zona: doze arquivos modificados, metade da refatoração quebrada, nada em estado de
commit. Você precisa trocar de contexto **agora**, sem commitar lixo e sem perder três horas de trabalho.

O Git tem duas respostas para isso: uma paleolítica e uma civilizada.

### 4.1 O Bolso Mágico: `git stash`

O `git stash` pega tudo o que você mexeu (arquivos rastreados, modificados e no stage), guarda num canto seguro e
devolve o seu diretório limpo, igualzinho ao último commit. É um "Ctrl+X" do seu progresso inteiro.

```bash
$ git stash
```

Diretório limpo. Agora você pode fazer `switch` para a `main`, criar a sua branch de hotfix e resolver a crise. Quando
voltar, recupera tudo de onde parou.

### 4.1.1 Guardando com Etiqueta

Um `stash` sem nome vira um mistério insolúvel em dois dias. Sempre descreva o que você guardou:

```bash
$ git stash push -m "refatoracao do modulo de auth pela metade"
```

### 4.1.2 Vendo o que Tem no Bolso

O stash é uma **pilha**. Você pode empilhar vários:

```bash
$ git stash list
stash@{0}: On feature/auth: refatoracao do modulo de auth pela metade
stash@{1}: On main: teste rapido que nao deu certo
```

Para espiar o conteúdo de um deles sem aplicar nada:

```bash
$ git stash show -p stash@{0}
```

### 4.1.3 `pop` vs. `apply`: a Diferença que Te Salva

Existem duas formas de recuperar o que você guardou:

- **`git stash pop`**: aplica o stash e **remove** ele da pilha. É o que você usa 90% das vezes;
- **`git stash apply`**: aplica o stash e **mantém** ele guardado. Útil quando você quer aplicar as mesmas mudanças em
  duas branches diferentes.

```bash
$ git stash pop             # aplica o stash@{0} e apaga da pilha
$ git stash apply stash@{1} # aplica um stash específico e mantém guardado
```

> **Cuidado com o `pop`:** se a aplicação der conflito, o Git resolve o que consegue, te deixa com os marcadores de
> conflito no arquivo **e não apaga o stash**. Você entra em pânico achando que perdeu tudo. Calma: rode `git stash
> list`, ele ainda está lá. Resolva o conflito na mão e depois dê `git stash drop` para limpar.

### 4.1.4 Os Arquivos que o Stash Ignora

Por padrão, o `git stash` **não guarda arquivos novos** (untracked) nem os ignorados pelo `.gitignore`. Se você criou um
arquivo e ainda não deu `git add` nele, ele fica para trás no diretório. Para levar tudo junto:

```bash
$ git stash -u   # inclui os arquivos untracked
$ git stash -a   # inclui até os ignorados pelo .gitignore (use com cautela)
```

Do Git 2.35 em diante, dá para guardar apenas o que está no stage:

```bash
$ git stash push --staged
```

### 4.1.5 Limpando a Bagunça

```bash
$ git stash drop stash@{1}   # apaga um stash específico
$ git stash clear            # apaga TODOS (sem confirmação, sem volta)
```

### 4.1.6 Quando o Stash Briga com o Presente

Você guardou um stash e, enquanto isso, a branch andou muito. Ao dar `pop`, tudo conflita. Em vez de sofrer, transforme
o stash numa branch nova a partir do commit onde ele nasceu:

```bash
$ git stash branch fix/refatoracao-auth stash@{0}
```

O Git cria a branch, faz o checkout, aplica o stash e o remove se tudo der certo. Ambiente limpo para terminar o
trabalho sem conflito.

### 4.1.7 A Verdade Sobre o Stash

O `git stash` é uma solução paleolítica. É uma pilha global, cega, sem vínculo com branch nenhuma, e é ridiculamente
fácil esquecer que você tem trabalho de três dias atrás enterrado no `stash@{4}`. Ele serve para **troca de contexto
rápida**: cinco minutos, um hotfix, e volta. Para qualquer coisa mais séria que isso, existe ferramenta melhor.

### 4.2 A Evolução: `git worktree`

E se você não precisasse guardar nada? E se pudesse ter a `main` e a sua feature abertas **ao mesmo tempo**, em duas
pastas diferentes, cada uma no seu estado, compartilhando o mesmo histórico?

É isso que o `git worktree` faz. Ele cria uma segunda árvore de trabalho ligada ao mesmo repositório `.git`. Sem clone
duplicado, sem baixar tudo de novo, sem stash.

### 4.2.1 Criando um Worktree

Você está em `~/projeto`, na branch `feature/auth`. O bug crítico aparece. Em vez de stashar:

```bash
$ git worktree add ../projeto-hotfix hotfix/login
```

Isso cria a pasta `~/projeto-hotfix` já com o checkout da branch `hotfix/login` (criando a branch, se ela não existir, a
partir do `HEAD`). Você abre outra aba do terminal, entra lá, conserta, commita, faz push e abre o PR. A sua pasta
original **nunca foi tocada** — a refatoração continua exatamente como estava.

Para já criar a branch nova junto com a árvore:

```bash
$ git worktree add -b feat/relatorios ../projeto-relatorios
```

### 4.2.2 Gerenciando os Worktrees

```bash
$ git worktree list                     # mostra todas as árvores e suas branches
$ git worktree remove ../projeto-hotfix  # apaga a árvore depois de terminar
$ git worktree prune                    # limpa referências de pastas deletadas na mão
```

### 4.2.3 A Regra de Ouro do Worktree

**A mesma branch não pode estar em dois worktrees ao mesmo tempo.** Se a `main` já tem checkout na pasta principal, o
Git recusa um `git worktree add ../outra main`. Isso é proteção: dois lugares editando a mesma branch seria o caos
absoluto. Cada worktree fica com a sua branch exclusiva.

### 4.2.4 Stash ou Worktree?

| Situação | Ferramenta |
|---|---|
| Interrupção de 5 minutos, um hotfix rápido | `git stash` |
| Trabalhar em duas frentes por horas ou dias | `git worktree` |
| Rodar o build e os testes nas duas versões ao mesmo tempo | `git worktree` |
| Guardar uma tentativa que talvez você jogue fora | `git stash` |
| Revisar o PR de um colega sem largar o seu trabalho | `git worktree` |

O `stash` é fita adesiva. O `worktree` é ter duas bancadas na oficina. Quanto mais sério for o projeto, mais você vai
viver de worktree e menos vai lembrar que o `stash` existe.
