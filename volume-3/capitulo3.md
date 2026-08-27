\newpage

# Capítulo III
\vspace{-1em}
## Pilhagem e Arrependimento - Cherry-pick e Revert
\vspace{1em}

Chegamos a um ponto de desenvolvimento em que fazer um `git merge` ou um `git rebase` inteiro é o mesmo que usar uma
bazuca para matar um mosquito. Às vezes, você não quer a branch inteira do seu colega; você quer apenas *aquele* commit
específico que resolve o seu problema imediato.

Outras vezes, o desastre já foi enviado para a branch `main` pública. Você não pode reescrever a história com um `git
reset` sem causar a Terceira Guerra Mundial no escritório. Você precisa de um botão de desfazer que seja educado e
auditável.

Para a cirurgia de precisão e para o perdão corporativo, o Git nos dá a pilhagem e o arrependimento.

### 3.1 A Pilhagem Perfeita: `git cherry-pick`

Imagine o cenário: o seu colega está trabalhando há três semanas numa branch obscura chamada `feature/payment-gatewau`.
No meio dessa bagunça inacabada, ele sem querer conserta um bug crítico de segurnça no login. Você, que está cuidando do
lançamento hoje, precisa urgentemente desse conserto na `main`, mas não pode fazer o `merge` da branch dele porque o
gateway de pagamento ainda quebra o sistema inteiro.

É aqui que você coloca seu chápeu de pirata e usa o `git cherry-pick`.

O `git cherry-pick` permite que você extraia as alterações de um commit específico de qualquer lugar do repositório e
aplique direto na sua branch atual, deixando o resto do lixo pra trás.

### 3.1.1 Executando o Roubo

Primeiro, você descobre qual é o hash do commit milagroso lá na branch do seu colega (usando o `git log`). Vamos dizer
que seja `a1b2c3d`.

Lembre-se da regra suprema da colaboração: nós nunca commitamos diretamente nas branches protegidas (`main` ou `dev`).
Portanto, vá para a sua branch base, atualize-a, e crie uma branch isolada para a sua missão de resgate:

```bash 
$ git switch dev
$ git fetch
$ git pull                               # Se necessário
$ git switch -c hotfix/login-security
```

Agora que você está em território seguro e isolado, execute a extração:

```bash
$ git cherry-pick a1b2c3d
```

Pronto. O Git pega a "diferença" daquele commit isolado e gera um **novo commit** na sua nova branch `hotfix`, mantendo
o mesmo autor e mensagem originais. Agora basta você dar um `git push` dessa branch, abrir o Pull Request, salvar a
produção e ignorar completamente o resto do código quebrado do seu colega.

### 3.1.2 O Perigo do "Fogo Amigo"

O `git cherry-pick` é viciante, mas ele esconde uma armadilha corporativa. Ele não apenas copia o código, ele **duplica
o histórico**. Ao roubar o commit do seu colega, você gera um novo hash na sua branch.

Se você estiver "roubando" de uma branch de *hotfix* que já foi merta ou de uma biblioteca abandonada, tudo bem. Mas se
você usar o `git cherry-pick` para puxar um código de uma **branch de feature ativa** do seu colega (um código que ainda
não foi aprovado num Pull Request), tome muito cuidado.

Se o seu colega precisar alterar aquele código de novo antes de enviar, e você já tiver injetado a versão antiga dele na
`main`, quando os dois tentarem abrir seus respesctivos Pull Requests, o Git vai entrar em parafuso com códigos
conflitantes vindos de locais e hashes diferentes. O `git cherry-pick` irresponsável gera Fogo Amigo na hora do Merge.

> **Nota do Autor:** Como usar o `git cherry-pick` de forma tática para fugir de bloqueios no meio do desenvolvimento,
> sem gerar conflitos de PR e limpando a sujeira depois, é uma arte que vai além do nível avançado. Discutiremos a fundo
> no Volume IV: Vida Real.

### 3.2 O Arrependimento Elegante: `git revert`

Se o `cherry-pick` serve para roubar o que é bom, o `git revert` serve para devolver o que é ruim. O cenário aqui é
outro: o desastre **já está** na `main`. Já foi puxado por oito pessoas, o deploy automático já rodou, o cliente já
reclamou. Fazer um `git reset` para apagar o commit problemático seria suicídio social, porque o histórico de todo mundo
passaria a divergir do seu.

Você precisa de um botão de desfazer que seja público, honesto e auditável. O `git revert` não apaga nada. Ele cria um
**commit novo** que é o espelho invertido da tragédia: tudo o que o commit original adicionou, ele remove; tudo o que
removeu, ele readiciona. A mancha continua no histórico, com o band-aid por cima, exatamente do jeito que uma auditoria
gosta de ver.

### 3.2.1 Reset vs. Revert: a Diferença que Salva Empregos

- **`git reset`** move o ponteiro para trás e finge que os commits nunca existiram. Ótimo na sua branch local privada.
  Catastrófico numa branch compartilhada;
- **`git revert`** anda para **frente**. Ele adiciona história em vez de subtrair. Ninguém precisa de `--force`, ninguém
  acorda com a branch quebrada, e fica registrado *quem* mandou desfazer e *quando*.

A pergunta que decide tudo: **esse commit já saiu da minha máquina?** Se saiu, o seu comando é `revert`. Se ainda está
só no seu computador, pode usar `reset` à vontade.

### 3.2.2 Executando o Desfazer

Descubra o hash do commit amaldiçoado com o `git log --oneline` e mande ver:

```bash
$ git revert a1b2c3d
```

O Git aplica a inversão, abre o editor com uma mensagem pronta (`Revert "mensagem original"`) e espera o seu OK. Se
você não está a fim de escrever uma redação justificando, pule o editor:

```bash
$ git revert --no-edit a1b2c3d
```

Pronto. Um commit novo, um `git push`, e a produção volta a respirar sem ninguém precisar entender de Git para continuar
trabalhando.

### 3.2.3 A Pegadinha do Merge Commit: a Flag `-m`

Aqui mora o erro clássico que faz gente sênior suar frio. Se você tentar reverter um **merge commit** do jeito normal, o
Git te corta na hora:

```bash
error: commit abc123 is a merge but no -m option was given.
```

Um merge commit tem **dois pais**: a linha principal (para onde você mergeou) e a branch que entrou. O Git não adivinha
qual dos dois lados você quer preservar. Você precisa apontar qual pai é a "linha da vida" com a flag `-m` (de
*mainline*):

```bash
# Mantém o pai 1 (normalmente a main) e desfaz tudo que a branch mergeada trouxe
$ git revert -m 1 abc123
```

Quase sempre é `-m 1`. O pai 1 é a branch que estava recebendo o merge; o pai 2 é a que foi absorvida.

### 3.2.4 Desfazendo em Lote

Precisa anular os últimos cinco commits de uma vez? Não rode o `revert` cinco vezes:

```bash
# Cria um commit de revert para cada commit no intervalo (do mais novo pro mais antigo)
$ git revert OLDHASH..HEAD
```

E se você quiser que tudo isso vire **um commit só**, use `--no-commit` para empilhar as inversões na Staging Area e
fechar você mesmo no final:

```bash
$ git revert --no-commit OLDHASH..HEAD
$ git commit -m "revert: desfaz a feature de pagamento inteira"
```

### 3.2.5 Revertendo o Revert (a Mordida que Volta)

Cenário que assombra os pesadelos: você reverteu um merge com `-m 1`. Semanas depois, o colega conserta a branch e faz o
merge dela de novo na `main`. Só que o Git enxerga aqueles commits como "já mergeados uma vez" — e o revert que você fez
continua valendo. Resultado: o merge "funciona", mas o código não volta.

A saída é reverter o seu revert antes de mergear de novo:

```bash
$ git revert <hash-do-seu-revert-anterior>
```

Isso reativa as mudanças originais, e aí sim o merge novo faz sentido. É confuso de propósito. A lição real é: **evite
reverter merge commits** quando der para reverter os commits individuais ou simplesmente refazer a branch do zero.

### 3.3 O Mapa Mental: Quatro Formas de Mexer no Passado

Antes de seguir para o próximo capítulo, fixe qual ferramenta serve para quê. Todas mexem em commits, mas com intenções
opostas:

| Comando | O que faz | Reescreve história? | Onde usar |
|---|---|---|---|
| `reset` | Move o `HEAD` para trás, descarta commits | Sim | Branch local privada, antes do push |
| `revert` | Cria um commit novo que anula outro | Não | Branch compartilhada, `main` pública |
| `cherry-pick` | Copia um commit específico para a branch atual | Não (gera hash novo) | Resgatar um fix isolado de outra branch |
| `rebase -i` | Reordena, funde e reescreve vários commits | Sim | Limpar a sua branch antes do Pull Request |

O eixo que separa as duas metades da tabela é sempre o mesmo: se o commit já foi compartilhado, você vive no mundo do
`revert` e do `cherry-pick`; se não foi, o `reset` e o `rebase` são seus amigos.
