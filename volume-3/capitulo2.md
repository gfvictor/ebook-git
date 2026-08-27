\newpage

# Capítulo II
\vspace{-1em}
## O Detetive de Código - Auditória e Debugging
\vspace{1em}

Na engenharia de software, existe uma certeza absoluta: o código vai quebrar. É algo além do seu controle, simplemente
acontece. E quando quebrar, a primeira pergunta na reunião diária não será "como consertamos?", mas sim "quem foi o
*individuo abençoado* que fez isso?". Exatamente assim, confia.

Para a sua sorte (ou azar), o Git possui as ferramentas mais implacáveis de auditoria já criadas. O Git não esquece. O
Git não perdoa. Neste capítulo, você vai aprender a rastrear a origem de qualquer linha de código e a encontrar aquele
commit amaldiçoado que derrubou a produção.

### 2.1 A Arte de Apontar o Dedo: `git blame`

Se o `git log` te conta a história do projeto, o `git blame` te conta a história de uma linha específica de código. O
nome do comando (do inglês "culpar") já entrega sem pudor o seu verdadeiro propósito no mundo corporativo.

Quando você encontra uma gambiarra indecifrável no meio de um arquivo e quer saber a quem ofender mentalmente, você usa
o `git blame`.

A sintaxe é tão direta quanto um soco:

```bash
$ git blame <nome do arquivo>
```

A saída vai te cuspir o arquivo inteiro, mas com um prefixo acusatório estampado em cada linha. Vai se parecer com isto:

```bash
^f9e8d7c (Joãozinho  2026-03-01 02:12:48) function autheticateUser() {
3a2b1c0d (Maria C.   2026-05-12 11:03:22) // TODO: refatorar depois
7b8c9d0e (Victor F.  2026-05-19 09:14:39)   return true; // bypass temporário
^f9e8d7c (Joãozinho  2026-03-01 02:12:48) }
```

Observe a anatomia da auditoria:

1. **Hash do Commit:** Para você saber exatamente em qual momento a tragédia foi introduzida (ex: 7b8c9d0e);
2. **Autor:** O nomeado (ex: Victor F.);
3. **Data e Hora:** Essencial para ver se o código foi feito às 3 da manhã numa sexta-feira, sob efeito de energéticos;
4. **O Código:** A linha exta que foi escrita.

Mas, se o arquivo for gigantesco, você pode investigar apenas um intervalo de linhas suspeitas:

```bash
$ git blame -L <número da linhas> <nome do arquivo>
```

> **Aviso de Humildade:** A parte mais perigosa do `git blame` é a alta probabilidade de você rodar o comando furioso,
> cheio de razão, apenas para descobrir que o autor da gambiarra foi você mesmo, seis meses atrás. E mesmo que não tenha
> sido você, não gere um conflito por causa de código, por favor. Fica o alerta.

### 2.2 A Busca Binária do Desespero: `git bisect`

O `git blame` é ótimo quando você sabe exatamente em qual linha o erro mora. Mas e quando o sistema inteiro para de
funcionar, os logs não dizem nada de útil, e a equipe empilhou 50 commits nos últimos dois dias? Você não faz idéia qual
arquivo ou qual commit quebrou o projeto.

Testar commit por commit, voltando no tempo de forma linear, é uma perda de tempo monumental. Para esses casos, te
apresento o `git bisect`.

O `git bisect` automatiza uma busca binária pelo histórico. Ele divide os commits pela metade, faz o checkout no meio do
caminho, te pede para testar o código, e com base na sua resposta ("tá bom" ou "tá quebrado"), ele divide a metade
restante de novo. Ele encontra o culpado no meio de 100 commits em apenas 6 ou 7 passos lógicos.

### 2.2.1 Iniciando a Caçada

Primeiro, você aivsa ao Git que o interrogatório vai começar:

```bash
$ git bisect start
```
Em seguida, você marca o estado atual da sua branch (que você já sabe que está quebrada e falhando):

```bash
$ git bisect bad
```

Depois, você precisa dar ao Git um "porto seguro". Encontre o hash de um commit mais antigo onde você tem **certeza
absoluta** de que o código funcionava perfeitamente e avise o Git:

```bash
$ git bisect good <hash do commit>
```
### 2.2.2 O Interrogatório

A partir desse momento, o Git toma o controle da sua máquina e faz o `checkout` automaticamente de um commit exatamente
no meio do caminho entre o "bom" e o "ruim".

Ele vai te dizer algo no terminal como:
- **Bisecting: 25 revisions left to test after this (roughly 5 steps)**

Agora o trabalho é seu. Teste o projeto. Suba o servidor, execute os testes unitários, clique no botão feio que estava
dando erro.

- Se o projeto funcionou: avise o Git digitando `git bisect good`;
- Se o projeto continou quebrado: avise o Git digitando `git bisect bad`.

O Git vai instantaneamente pular para a próxima metade lógica. Você repete esse teste rápido até que ele te dê a
sentença final, apontando o dedo na cara do culapdo:

```bash
9b8a7c6 is the first bad commit
commit 9b8a7c6
Author: Victor F.
Date:   Mon Feb 11 00:14:55 2026 -0900
    "chore: Atulizando dependências na pressa"
```

### 2.2.3 Fechando o Caso

Depois de encontrar o commit amaldiçoado (e anotar o hash pra consertá-lo, ou esganar quem fez), você precisa encerrar a
caçada, mandar o Git tirar o chápeu de detetive e devolver a sua máquina para o estado presente (o HEAD de onde você
partiu lá do início):

```bash
$ git bisect reset
```

Dominar o `git bisect` e o `git blame` é o que te tira da categoria de "desenvolvedor que senta e chora quando a main
quebra" e te eleva ao patamar de "engenheiro que resolve o problema antes do almoço", e, possivelmente, garante uns tapinhas nas costas.
