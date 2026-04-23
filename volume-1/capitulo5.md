\newpage

# Capítulo V
\vspace{-1em}
## O Multiverso das Branches
\vspace{1em}

Se você chegou até esse capítulo sem apagar seu diretório `.git` por frustação, parabéns. Você já sabe o básico para não ser um completo desastre. Mas agora vamos falar sobre como trabalhar como um profissional. Imagine que você está desenvolvendo uma funcionalidade nova, mas o código atual já está estável. Você não quer mexer no que está funcionando e correr o risco de quebrar tudo, certo? Certo.

Bem-vindo ao conceito de *Branches* (Ramificações).

### 5.1 O que Diabos é uma Branch?

Vamos deixar de lado a analogia do supermercado por um instante. Agora, pense no Git como uma árvore. O tronco principal é o `main` ou `master`. Uma branch é, literalmente, um galho dessa árvore. Você cria um "puxadinho", faz toda a bagunça naquele galho, e o tronco pricipal continua intacto. 

Uma branch não está limitada a ser criada a partir do tronco principal. Você pode criar galhos a partir de galhos, que partem de outros galhos, e se perder, caso não saiba o que está fazendo.

### 5.1.1 Criando sua Primeira Linha Temporal

Por padrão, você começa na branch `main`. Para ver onde você está:

```bash
$ git branch
```

Para criar uma nova branch **primeiro-teste**:

```bash
$ git branch primeiro-teste
```

> **Dica:** Existem alguns padrões para nomenclatura de branches em projetos sérios, mas essas nomenclaturas podem variar de acordo com o ambiente que você for trabalhar, com sua equipe, tipo de projeto, etc.. Apenas saiba que você não deve se acostumar a dar nomes aleatórios para suas branches, como "branch do zequinha". Crie nomes relevantes, que descrevam a função dessa branch, de preferência com um prefixo, como `feat/jwt-auth` ou `fix/page-layout`.

### 5.1.2 Viajando Entre Universos: `git switch`

Criar a branch não te joga pra dentro dela. Para mudar de caixa e entrar na sua nova realidade:

```bash
$ git switch primeiro-teste
```

Qualquer arquivo modificado aqui pertencerá apenas a este universo. Se você voltar para a `main`, essas mudanças simplesmente sumirão do seu disco até você voltar para a branch de testes. Mais para frente, no próximo volume, você vai aprender como fazer com que essas mudanças persistam e alcancem todas as outras branches, usando `merge`.

### 5.1.3 Deletando o que Não Serve Mais

Aquela idéia era horrível? Apague sem piedade. Você precisa sair da branch para apagá-la:

```bash
$ git switch main
$ git branch -d primeiro-teste
```

> **Mais uma Dica:** Crie uma branch para cada idéia. É de graça e evita que sua `main` vire um cemitério de códigos comentados que não funcionam. Mantenha seu código limpo e legível. Obrigado.
