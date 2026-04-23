\newpage
\pagestyle{fancy}
\pagenumbering{arabic}
\setcounter{page}{1}
\fancyhead[R]{\textit{Volume II: Intermediário}}

# Capítulo I
\vspace{-1em}
## O Espelho na Nuvem
\vspace{1em}

Se o seu laptop cair na privada amanhã, o seu código sobrevive? Se a resposta for "não", você (ainda) não é um desenvolvedor, você é um temerário. Mas ainda podemos ser amigos. Prepare o seu café (ou o seu Monster, se você ainda tiver vinte anos) e vamos em frente.

### 1.1 Git vs. GitHub - Sim, São Coisas Diferentes

Ainda tem gente que confunde os dois, e está tudo bem. Vamos entender de uma vez:

- **Git:** É o motor. É o software que você usa no terminal para gerir as versões;
- **GitHub/GitLab:** São "hotéis". Servidores remotos que rodam Git e oferecem uma interface web bonitinha para você visualizar o seu código e colaborar.

### 1.2 SSH: O Aperto de Mão Secreto

No Volume I, você aprendeu a gerar um par de chaves SSH - pública e secreta - na sua máquina. Não lembra? Vamos refrescar sua memória:

```bash
$ ssh-keygen -t ed25519 -C "seu-email@provedor.com"
```

> * Não esqueça a senha que você colocou para as suas chaves, ou vai precisar fazer novas.

**Adicionando ao GitHub:**

1. Copie o conteúdo do arquivo .pub gerado:
```bash
$ cat ~/.ssh/id_ed25519.pub
```

2. Cole nas configurações de *SSH and GPG Keys*, no seu perfil.

Pronto. O GitHub sabe quem você é e você agora pode trabalhar com ele. Sejam amigos, ok?

### 1.3 O Primeiro Vínculo: `git remote`

Para que sua pasta local saiba que existe um "espelho" dela na internet, você precisa adicionar um `remote`.

```bash
# O nome padrão de conexão remota é sempre 'origin'
$ git remote add origin git@github.com:seu-usuário/seu-repo.git
```

> * Quando você clona um repositório, o Git cria automaticamente um apelido chamado `origin` que aponta para a URL de onde o código veio. Mas `origin` não é uma palavra mágica do sistema; é apenas um nome convencional. Você pode ter quantos remotos quiser(!) e chamá-los do que bem atender. 

Agora, o seu Git local tem um destino. Mas, por que se contentar com apenas um quando você pode ter vários ao mesmo tempo?

### 1.4 Multiverso de Provedores: GitHub e GitLab em Simbiose

Imagine que você trabalhe em uma empresa que usa GitLab, mas você quer manter seu portfólio no GitHub sempre atualizado, porque você é **paranóico** ou ter o *Grid de Contribuições* todo verdinho é o que te faz sorrir. Primeiro, você precisa se tratar. Sério. Mas, se ainda assim você tiver algum outro motivo nobre para ter uma cópia dos seus arquivos em dois servidores diferentes, existe a possibilidade.

Para adicionar um segundo remoto:
```bash
# Adicionando o GitHub como 'origin' (o principal)
$ git remote add origin git@github.com:seu-usuário/seu-repo.git

# Adicionando o GitLab como um backup chamado 'lab'
$ git remote add lab git@gitlab.com:seu-usuário/seu-repo.git
```

Agora, para ver suas conexões:

```bash
$ git remote -v 
```

### 1.5 O Truque do "Push Duplo" (Multi-Remote Push)

Claro que não adianta nada ter dois remotes se isso significa ter trabalho em dobro. Enviar o código para dois lugares manualmente - `git push origin main` e depois `git push lab main` - é coisa de quem tem tempo sobrando. Como somos muito ocupados, podemos ser produtivos e configurar o Git para que um único comando envie para ambos.

Vamos adicionar uma nova URL de push ao nosso remoto `origin` existente:

```bash
$ git remote set-url --add --push origin 
  git@gitlab.com:seu-usuário/seu-repo.git
```

**O Que Aconteceu Aqui?**

Agora, quando você digitar `git push origin main`, o Git vai ler a lista de URLs de push e disparar os arquivos para os dois servidores simultaneamente. É a forma mais elegante de manter seus "quadradinhos verdes" sincronizados sem precisar de um bot de automação fuleiro. De nada.

### 1.5.1 Removendo e Renomeando

Se você digitou o nome do remoto errado ou o servidor mudou de endereço (ou você errou isso também, na verdade):

```bash
# Mudando o nome de un remote
$ git remote rename <nome-antigo> <nome-novo>

# Removendo uma conexão que não faz mais sentido
$ git remote remove <nome-do-remote>
```

Dominar os remotes é o primeiro passo para a maestria da colaboração. Você não pertence a uma plataforma; as plataformas que têm o privilégios de hospedar o seu código.
