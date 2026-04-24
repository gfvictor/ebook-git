\newpage

# Capítulo II
\vspace{-1em}
## Sicronização e a Anatomia do Fluxo
\vspace{1em}

No capítulo anterior, estabelecemos as pontes (`git add remote`). Agora, vamos aprender a trafegar por elas. Sincronizar código não é apenas "enviar e receber"; é garantir que a sua realidade local e a realidade da nuvem coexistam sem criar um paradoxo temporal que destrua seu projeto. E isso não é um exagero. Acontece.

### 2.1 O Observador Silencioso: `git fetch`

O erro número um do iniciante é achar que o `git pull` é o único comando para obter novidades. Um desenvolvedor prossional, ou pelo menos experiente, usa o `git fetch`.

Quando você executa um `git fetch`, o Git descarrega todos os metadados e arquivos do servidor remoto, mas **não mexe nos seus ficheiros**, e isso é importante que você entenda isso. O `git fetch` é como ler o jornal: você fica sabendo o que aconteceu no mundo, mas isso não muda o que está dentro da sua casa. Quase ninguém "lê jornal" hoje em dia, mas fica aí a analogia. 

```bash
$ git fetch origin
```

Após este comando, você pode ver o que os seus colegas fizeram sem correr o risco de quebrar ou sobrescrever o seu código atual. É o comando da segurança e da prudência.

### 2.2 As Ramificações Remotas (*Tracking Branches*)

Aqui está mais um segredo que separa os homens dos meninos: quando você faz um `git fetch`, o Git atualiza as chamadas ***Remote-Tracking Branches***. Elas aparecem no seu terminal como `origin/main`, `origin/feat/xxxx`, etc.

Essas branches sã9 como fotografias do estado do servidor. Você não pode trabalhar nelas diretamente. Elas servem como um ponto de comparação.

Para ver a diferença entre o que você tem e o que está no servidor (após o fetch, claro):

```bash
$ git log main..origin/main
```

Ou seja, você está pedindo "me mostra o que a `origem/main` tem que eu não tenho na minha `main` local".

### 2.3 O Casamento por Conveniência: `git pull`
