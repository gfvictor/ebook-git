\newpage

# Capítulo III
\vspace{-1em}
## Sicronização e a Anatomia do Fluxo
\vspace{1em}

No Capítulo I, estabelecemos as pontes (`git add remote`). Agora, vamos aprender a trafegar por elas. Sincronizar código não é apenas "enviar e receber"; é garantir que a sua realidade local e a realidade da nuvem coexistam sem criar um paradoxo temporal que destrua seu projeto. E isso não é um exagero. Acontece.

### 3.1 O Observador Prudente: `git fetch`

O `git fetch` é, provavelmente, o comando mais subestimado do Git. Ele é o comando do desenvolvedor que pensa antes de agir. O erro número um do iniciante é achar que o `git pull` é o único comando para obter novidades.

Quando você executa um `git fetch`, o Git descarrega todos os metadados e arquivos do servidor remoto, mas **não mexe nos seus arquivos**, e é importante que você entenda isso. O `git fetch` é como ler o jornal: você fica sabendo o que aconteceu no mundo, mas isso não muda o que está dentro da sua casa. Quase ninguém "lê jornal" hoje em dia, mas fica aí a analogia. 

```bash
$ git fetch origin
```

Após este comando, você pode ver o que os seus colegas fizeram sem correr o risco de quebrar ou sobrescrever o seu código atual. É o comando da segurança e da prudência.

### 3.1.1 As Ramificações Remotas (*Tracking Branches*)

Aqui está mais um segredo que separa os homens dos meninos: quando você faz um `git fetch`, o Git atualiza as chamadas ***Remote-Tracking Branches***. Elas aparecem no seu terminal como `origin/main`, `origin/feat/xxxx`, etc.

Essas branches são como fotografias do estado do servidor. Você não pode trabalhar nelas diretamente. Elas servem como um ponto de comparação.

Para ver a diferença entre o que você tem e o que está no servidor (após o fetch, claro):

```bash
$ git log main..origin/main
```

Ou seja, você está pedindo "me mostra o que a `origem/main` tem que eu não tenho na minha `main` local".

### 3.2 O Atalho Perigoso: `git pull`

O famoso `git pull` nada mais é do que um comando "dois em um". Ele é preguiçoso por natureza. Quando você o executa. o Git faz:

1. Um `git fetch` (vai buscar as novidades);
2. Um `git merge` (tenta fundir essas novidades na sua branch atual).

Acontece que o `git pull` assume que você quer fundir as alterações **agora**. E ele não vai perguntar se você quer ou não. Se você e seu colega alteraram a mesma linha, o `git pull` vai te jogar direto em um conflito de merge sem aviso prévio.

O comportamento padrão do `pull` é criar um "Merge Commit" toda vez que os históricos local e remoto divergem. Se você trabalha em uma equipe ativa, seu histórico do Git logo parecerá um prato de espaguete, cheio de mensagens inúteis como "*Merge branch `main` of github.com...*", ou coisa parecida. Isso dificulta a auditoria e torna o `git log` uma leitura insuportável, até mesmo com a flag `--oneline`.

### 3.3 Entendendo os Movimentos: *Fast-Foward* vs *Three-Way Merge*

Mais uma vez, um ponto importante que define a maestria do Git. Vamos lá, porque você ainda tem chão até chegar no topo dessa montanha.

Quando o Git tenta unir as histórias (durante um `git pull` ou `merge`), ele decide fazer isso baseado no estado dos commits.

### 3.3.1 Fast-Forward (ou Avanço Rápido se Você Curte pt-BR)

Imagine que você ainda criou uma branch `feat/xxxx`, mas ninguém mexeu na `main` desde então. A história é linear. Quando você une as duas, o Git simplesmente move o ponteiro da `main` para a frente, até encontrar o último commit da `feat/xxxx`.

> **Resultado:** Um histórico limpo, reto e sem commits extras. O cenário ideal, então agradeça a sua sorte.

### 3.3.2 Three-Way Merge (O "Merge de Verdade")

Agora imagine que você mexeu na sua branch e, enquanto isso, o Zequinha Dev subiu um commit na `main`. As histórias divergiram. E aí? Agora é o seguinte:

Para unir esses dois universos, o Git precisa criar um novo commit - o **Merge Commit**. Ele olha para o *ancestral comum* das duas branches conflitantes, olha pra **sua versão** e para a **versão do servidor**, e cria um novo commit que une os dois mundos. 

> **Resultado:** Aquelas mensagens chatas de ˜Merge branch `main` of..." que poluem o seu log.

### 3.4 A Alternativa Elegante: `git pull --rebase`

Desenvolvedores intermediários preferem manter um histórico limpo e linear. Se você é um deles (ou, ao menos, pretende ser) sua ferramenta é a flag `--rebase`. Ao usá-la, você diz ao Git:

1. Pegue meus commits locais e guarde eles em uma área temporária;
2. Traz os commits novos do servidor para minha branch (fazendo um Fast-Forward);
3. Coloque meus commits de volta, um por um, no topo do histórico.

```bash
$ git pull --rebase origin main
```

> **Vantagem:** O histórico fica como se você tivesse começado a trabalhar *depois* que todos os seus coleguinhas terminaram. É limpo, profissional e fácil de ler.

### 3.5 Quando o `push` é Rejeitado (Non-Fast-Foward)

Você tenta dar um `git push` e o Git cospe um erro: `[rejected] (non-fast-forward)`. Isso significa que o servidor tem commits que você não tem. O Git se recusa a sobrescrever o trabalho alheio.
Isso é bom? Depende.

**O Fluxo de Trabalho Intermediário:**

1. `git fetch origin`: Você vê o que mudou sem quebrar nada;
2. `git log main..origin/main`: Analisa o que os outros fizeram;
3. `git pull --rebase origin main`: Traz as mudanças e coloca as suas no topo;
4. `git push`: Agora sim, você está à frente do servidor e o push será aceito.

> **Atenção:** Você deve ter percebido que o exemplo de fluxo acima é para a branch `main`. Então, caso você precise seguir estas etapas para outra branch, basta mudar o nome. Mas você deve ter entendido a explicação, certo? Certo.

### 3.6 Gerenciando Fantasmas: `git fetch --prune`

Trabalhar em equipe significa que branches morrem o tempo todo. Quando um colega deleta uma branch no GitHub, ela ainda fica aparecendo para você como `origin/branch-morta`. Para limpar essa bagunça:

```bash
$ git fetch --prune
```

Isso sincroniza sua lista de branches remotas com a realidade atual do servidor, removendo tudo o que foi deletado e permitindo que as branches que morreram façam finalmente a passagem pra outro plano. Amém.
