\newpage

# Capítulo IV
\vspace{-1em}
## A Máquina do Tempo (E Como Não Ser Demitido)
\vspace{1em}

Errar é humano. Desfazer o erro sem que ninguém perceba a sua incompetência é Git. 

Se você chegou até aqui, já sabe criar arquivos, prepará-los e salvá-los. Mas a vida não é um comercial de margarina, e você vai fazer bobagem. Pode ser um código que parou de funcionar misteriosamente, porque talvez você foi querer enfeitar demais e mudou uma linha na regra de nogócio do componente principal, ou coisa parecida. Mas quem nunca, não é?

Este capítulo é o seu botão de "Pânico". Vamos aprender a voltar no tempo e fingir que aquele desastre de código nunca aconteceu.

### 4.1 Quando Você Achou que Tudo Estava Perdido: `git restore`

Sabe aquele momento em que você decide "limpar" o código, apaga ou modifica uma função achando "assim vai ficar melhor, mais profissional", o programa para de compilar e você esqueceu o que tava escrito ali antes? Em vez de chorar em posição fetal, use o `git restore`.

Ele serve para dizer ao Git: "Pegue este arquivo do jeito que ele estava no último commit e jogue por cima dessa bagunça que eu fiz no meu diretório de trabalho, por favor".

```bash
# Restaura o arquivo ao estado do último snapshot salvo:
$ git restore nome-do-arquivo
```

> **Atenção:** Esse comando sobrescreve o que você fez. Se não salvou (com o commit), já era. Ele vai desconsiderar todas as suas mudanças e restaurar o arquivo ao último commit que foi enviado, apagando as mudanças (nesse caso, ao seu favor, apagando a besteira e recuperando o código correto). Use com a certeza de quem sabe que o que está na tela não vale o espaço que ocupa no SSD.

### 4.2 Se Você Muda de Idéia na Última Hora: `git restore --staged`

Você deu um `git add .` (ou seja, adicionou todos os arquivos à Staging Area, de uma vez) e, no meio da empolgação, foi junto aquele famigerado arquivo `.env` cheio de segredos. Acredite, isso acontece muito com quem está começando. Todo mundo já passou por isso. Agora, o arquivo está na **Staging Area** (em verde), pronto pra ser imortalizado no commit.

Como tirá-lo do "carrinho de compras" sem deletar o arquivo do seu computador?

```bash
$ git restore --staged arquivo-proibido
```

Pronto. O arquivo volta a ficar *vermelho* (Untracked ou Modified). O Git agora finge que nunca viu esse arquivo na fila do pão. Aliás, **sempre** adicione o `.env` ao arquivo `.gitignore`, e **nunca** apague um arquivo adicionado à Staging Area antes de removê-lo. De Nada.

### 4.3 O botão Nuclear: `git reset`

Conforme prometido no prefácio deste manual, vamos falar do comando que separa os adultos das crianças. O `git reset` move a *cabeça* (HEAD) do seu projeto para um ponto anterior da história. No nível iniciante, focaremos em dois sabores:

### 4.3.1 `git reset --soft` - Apenas um Susto

Você fez o `git commit`, mas se arrependeu, por algum motivo qualquer. O `git reset --soft` desfaz o commit, mas mantém todas as alterações que você fez preparadas na Staging Area. É como se o tempo voltasse um minuto, mas você ainda estivesse com os produtos no carrinho de compras na frente do caixa.

```bash
# Desfaz o último commit, mas mantém os arquivos:
$ git reset --soft HEAD~1
```

### 4.3.2 `git reset --hard` - O Exterminador do Futuro

Use isso e o Git vai **deletar tudo** o que foi feito após o commit escolhido. Não há lixeira, não há prompt de confirmação. Apenas destruição. É o comando perfeito para quando o projeto virou um emaranhado de bugs tão grande que o melhor é simplesmente fingir que o dia de hoje nunca existiu.

```bash
# Apaga TUDO e volta ao estado do commit indicado
$ git reset --hard <Hash do commit>
```

### 4.3.3 Na Prática, Qual a Diferença Real?

O `git reset` é uma arma poderosa, mas com um grande poder vem com uma grande responsabilidade. Se você ainda está confuso, pense no Git como um supermercado:

- **Diretório de Trabalho:** Suas mãos (onde você mexe nos produtos);
- **Staging Area:** O seu carrinho de compras (onde você separa o que vai levar);
- **Commit:** O recibo pago e os produtos guardados no seu estoque em casa.

Quando você usa o `git reset --soft`, você está apenas estornando o recibo. o Git te diz: "Ok, devolvi o recibo, mas os produtos continuam aqui no seu carrinho, prontos pra você passar no caixa de novo". Você não perde o que escreveu, você apenas ganha a chance de mudar a mensagem do commit ou adicionar um item de última hora.

Já o `git reset --hard` é o equivalente a você pedir devolução por insatisfação. O Git te diz: "Você não quer mais esses produtos? Tudo bem, vou fazer o estorno e pegá-los devolta. Vamos fingir que essa compra nunca aconteceu". TUDO o que você escreveu e não salvou como commit até o *Hash* solicitado será **deletado permanentemente**. Use isso apenas quando você realmente quiser começar do ponto que você pediu pra voltar, como se nada tivesse acontecido.

### 4.4 Visualizando o Mapa do Tempo: `git log --oneline`

No capítulo anterior, você conheceu o comando `git log` comum, que é um monstro de informações que ninguém tem paciência de ler. Para usar o `git reset` ou qualquer comando que exija um *ponto no tempo*, você precisa do *Hash* do commit e para sua sorte existe um comando que te dá essa informação de forma simplificada que é mais usado no dia a dia:

```bash
$ git log --oneline
```

Isso vai cuspir algo assim:

```bash
f7a2b3c (HEAD -> main) add refresh token
a1b2c3d add login component
e5f6g7h initial commit
```

Os 7 caracteres alfanuméricos no início (por exemplo, o `f7a2b3c`) são o ***Hash curto***. Eles são tudo o que você precisa pra identificar um commit e usá-lo em qualquer comando de ˜máquina do tempo". É rápido, é limpo, é maravilhoso, e de quebra ainda faz você parecer alguém que sabe o que está fazendo no terminal.

### 4.5 A Milagrosa tag `--amend`

Você acabou de fazer um commit e percebeu um erro de digitação na mensagem ou de adicionar aquele arquivo com o `git add`. Em vez de fazer um novo commit ou `git reset --soft`, você tem a opção de usar o `--amend`.

```bash
$ git commit --amend -m "Message without mistakes"
```

O Git vai "abrir" o último commit e substituí-lo por esse novo, sem precisar voltar tudo pra Staging Area. No historico do projeto vai parecer que você nunca erra. Impressionante.
