\newpage
\pagenumbering{arabic}
\setcounter{page}{1}
\fancyhead[R]{\textit{Volume III: Avançado}}

# Capítulo I
\vspace{-1em}
## O Cirurgião do Histórico
\vspace{1em}

Caso você trabalhe com desenvolvimento de software há mais de duas
semanas, provavelmente já fez alguma besteira da qual se arrependeu
amargamente. Talvez tenha apagado um branch que não devia, ou feito um
commit com a mensagem "ahsahsasd" e agora está com vergonha de mandar
isso para o repositório remoto.

### 1.1 A Rede de Segurança dos Desesperados: `git reflog`

Muitos desenvolvedores acham que um `git reset --hard` é uma sentença
de morte para os arquivos não comitados e até para os commits
descartados. Para os arquivos não rastreados, a morte é certa. Mas
para os commits... Os commits, jovem. O Git tem um diário secreto.

O `git reflog` (Reference Logs) é basicamente um registro de todos as
movimentações que o `HEAD` fez no seu repositório local. Você fez um
checkout? Fica no reflog. Fez um commit? Reflog. Fez um `reset`
destrutivo? Reflog.

### 1.1.1 Como Visualizar o Desastre

Basta rodar o comando:
```bash
$ git reflog
```

A saída será algo do tipo:

```bash
a1b2c3d (HEAD -> main) HEAD@{0}: reset: moving to HEAD~1
f9e8d7c HEAD@{1}: commit: Add function xxxx
d7e8f9g HEAD@{2}: checkout: moving from feature-branch to main
```

Você lê de cima para baixo. O `HEAD@{0}` é onde você está agora. O
`HEAD@{1}` era onde você estava **antes** de fazer a útlima besteira
(o reset).

### 1.1.2 Como Voltar no Tempo (com Estilo)

Descobriu que a vida era melhor no `HEAD@{1}` e quer voltar para lá?
Simples, você usa aquele mesmo comando destrutivo que te colocou nessa
situação em primeiro lugar, mas agora apontando para o reflog:

```bash
$ git reset --hard HEAD@{1}
```

Ou se preferir usar o **hash** do commit diretamente:

```bash
$ git reset --hard f9e8d7c
```

Pronto. Mágica feita, emprego salvo. O `reflog` mantém o histórico
localmente por padrão durante ***90 dias*** para refs alcançàveis e ***30 dias*** para refs inalcançáveis. Então, se você estragou tudo, você tem um mês para se arrepender.

### 1.2 A Arte da "Falsificação": `git rebase -i`

Se o `reflog` salva você de acidentes, o `rebase -i` salva você da
vergonha. Ele permite que você **pause** o tempo e reescreva o
histórico de commits local antes de enviá-la para a equipe.

Você pode alterar mensagens de commit, combinar vários commits inúteis
em um só, reordenar a ordem em que aconteceram e até jogar commits
inteiros no lixo. Controle total.

### 1.2.1 Iniciando a Cirurgia

Suponha que você queria limpar os últimos 3 commits da sua branch
atual antes de enviar o seu trabalho. Você executa:

```bash
$ git rebase -i HEAD~3
```

Seu editor de texto configurado no terminal (espero que você tenha
aprendido a usar o NeoVim) vai abrir com um arquivo parecido com isto:

```bash
Rebase 1d2c3b4..9b8a7c6 onto 1d2c3b4 (3 commits)

Commands:
p, pick <commit> = use commit
r, reword <commit> = use commit, but edit the commit message
e, edit <commit> = use commit, but stop for amending
s, squash <commit> = use commit, but meld into previous commit
d, drop <commit> = remove commit
```

A ordem aqui é cronológica inversa (o mais antigo no topo). O Git vai
executar este script **de cima pra baixo**.

### 1.2.2 Os Comandos do Bisturi

Você não edita o código aqui, você edita a palavra `pick` na frente do
**hash** do commit. Aqui estão os comandos mais usado para não parecer
um amador:

- **`pick` (ou `p`):** Mantém o commit exatamente como está;
- **`reword` (ou `r`):** Mantém as alterações do código, mas pausa
  para você digitar uma mensagem de commit mais profissional;
- **`squash` (ou `s`):** Junta as alterações deste commit com o commit
  da linha de cima. É perfeito para esconder os famosos commits
  "fix typos", "pipeline test", "new version";
- **`drop` (ou `d`):** Apaga o commit da face da Terra (e do seu  histórico).

Por exemplo, para arrumar a mensagem do segundo commit e juntar o
terceiro com o segundo, você deixaria assim:

```bash
$ pick 3a2b1c0 add login route
$ reword 8f7e6d5 fix route typo
$ squash 9b8a7c6 WIP: testing routes
```

Salve e feche o arquivo. O Git vai pausar e abrir o editor novamente
para você escrever a nova mensagem de commit consolidada para o
`squash`.

### 1.3 A Regra de Ouro do Rebase

Existe uma regra sagrada no uso do `rebase`: **Nunca, em hipótese
alguma, faça rebase de commits que já foram enviados com `push` para
um repositório remoto público que outras pessoas estão utilizando.**
Acho que você, a essa altura já deve saber o motivo desse cuidado
extra.

O rebase reescreve a história. Ele cria novos hashes para os commits.
Se você alterar o histórico que um colega de trabalho já baixou, a
próxima vez que ele tentar sincronizar o código, o Git vai entrar em
pânico e a amizade de vocês vai acabar em um inferno de conflitos.

Use o `rebase -i` livremente na sua máquina local, nas suas branches
privadas, **antes** do push. Limpe a sujeira antes de convidar visitas
para entrar.
