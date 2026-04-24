\newpage

# Capítulo III
\vspace{-1em}
## Gestão e Resolução de Conflitos e Crises
\vspace{1em}

Jovem, se você ainda não encarou um conflito de merge (mesmo que seja no seu próprio projeto solo, por organização de menos e café demais), você ainda não trabalhou em um projeto real. No momento em que você deixa de ser um desenvolvedor solitário e passa a integrar uma equipe, o Git deixa de ser apenas sobre versionamento e passa a ser sobre diplomacia técnica. Conflitos são o preço que você paga pela colaboração paralela.

### 3.1 O que é, Afinal, um Conflito?

Um conflito ocorre quando o Git tenta fundir duas histórias e descobre que a mesma linha de um arquivo foi alterada de formas diferentes em ambas as ramificações.

O Git é inteligente, mas ele não é telepata. Ele não sabe se a versão correta é a sua, a do coleguinha ou uma mistura das duas. Nesses casos, ele para o processo, cruza os braços e diz: "Resolve você, porque eu é que não vou adivinhar".

### 3.1.1 Conflito vs. Rejeição 

Alguns desenvolvedores confundem *Conflito* com *Rejeição de Push*. Quando você tenta dar um `git push` e o terminal cospe uma mensagem de erro dizendo `[rejected] (non-fast-foward)` (como dito anteriormente), o Git está te avisando que a história do servidor mudou enquanto você trabalhava.

O `git push` nunca causará conflitos diretamente no servidor (ainda bem!). Ele apenas avisa: "Eu não posso subir isso porque você vai apagar o que seu coleguinha já fez primeiro". O conflito **nasce** na sua máquina quando você tenta resolver essa rejeição usando um `git pull`.

### 3.2 A Anatomia do Caos: Entendendo Marcadores

Quando um conflito explode, o Git altera o conteúdo do arquivo problemático e insere marcadores visuais. Entender esses símbolos é o primeiro passo para não fazer bobagem.

```bash
<<<<<<< HEAD
print("Hello, World!")    # Sua versão local
=======
print("Salve, galera!")  # A versão do servidor
>>>>>>> feat/xxxx
```

- **`<<<<<<< HEAD`:** Início das suas mudanças locais;

- **`=======`:** A fronteira entre os dois mundos;

- **`>>>>>>>`:** O fim das mudanças da branch que está sendo integrada.

Sua missão, caso você aceite, é abrir o arquivo, apagar esses marcadores e decidir qual código deve permanecer.

### 3.3 Os Dois Caminhos da Resolução 

Como explicado no capítulo anterior, existem duas formas principais de integrar código: `merge` e `rebase`. Dependendo de qual você escolheu antes do conflito aparecer, o comando de finalização será diferente.

### 3.3.1 Caminho A: Conflito no `merge` (ou `git pull` padrão)

Se você deu um `git pull` simples e o conflito apareceu:

1. **Resolva o Arquivo:** Abra no editor e limpe os marcadores;
2. **Adicione:** `git add <arquivo>`;
3. **Conclua:** `git commit`. O Git fechará o ciclo de Merge.

### 3.3.2 Caminho B: Conflito no `rebase`

Se você deu um `git pull --rebase` e algo conflitou, o Git entra no estado **REBASE-i**.

1. **Resolva o Arquivo:** Limpe os marcadores no editor;
2. **Adicione:** `git add <arquivo>`;
3. **Continue:** `git rebase --continue`

> **Atenção:** Aqui você ***não*** faz commit. O Git "despausa" e tenta aplicar o seu **próximo** commit.

### 3.3.3 `rebase` vs. `--rebase`

Vamos esclarecer essa dúvida que com certeza deve estar habitando um espaço na sua cabeça:

- `git rebase <branch>` é um comando manual. Você está dizendo: "Quero pegar meu trabalho atual e colocar em cima da história daquela outra branch". Cuidado.
- `git pull --rebase` é um atalho. Ele faz o fetch (traz o que tem no servidor) e já emenda um rebase automático do seu trabalho local sobre o que acabou de baixar.

Ambos levam ao mesmo lugar, mas o segundo é o que você vai uzar 99% do tempo no dia a dia para manter o seu histórico limpo.

### 3.4 Desistir é uma Opção

Se você percebeu que a resolução está ficando complexa demais ou que você tentou integrar a branch errada, você pode abortar tudo e voltar ao estado anterior ao conflito como se nada tivesse acontecido. Não há vergonha nenhuma em dar um passo atrás se o problema for muita areia pro seu caminhão. Acontece.

```bash
$ git merge --abort

# OU, se estiver no meio de um `rebase`:
$ git rebase --abort
```

### 3.5 Estratégias para Minimizar Conflitos

Conflitos são inevitáveis, mas a frequência deles depende da maturidade da equipe:
-  **Commits de Tamanho Controlado:** Commits pequenos diminuem a "área de contato" para erros;
- **Sincronização Frequente:** Não fique três dias isolado. Dê um `git fetch` e um `git pull --rebase` diaramente;
-  **Comunicação:** Se dois mexem no mesmo arquivo ao mesmo tempo, o problema é a falta de conversa, não o Git.
