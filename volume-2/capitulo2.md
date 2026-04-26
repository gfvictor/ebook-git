\newpage

# Capítulo 2
\vspace{-1em}
## Portais de Entrada
\vspace{1em}

### 2.1 A Máquina Xerox: `git clone`

O `git clone` é o comando que você usará para baixar um repositório completo de um servidor remoto. Diferente de baixar um arquivo `.zip` do GitHub, o `git clone` traz **todo o histórico de commits**, todas as branches e todas as tags.

```bash
$ git clone git@github.com:dono-original/repositório.git 
```

### 2.1.1 O Que o `git clone` Faz Por Baixo dos Panos?

Muitos iniciantes não percebem, mas o Clone automatiza três passos que você aprendeu a fazer manualmente no capítulo anterior:

1. Cria a pasta do projeto no diretório que você está atualmente;
2. Executa o `git init`;
3. Adiciona o `git remote` automaticamente com o nome de `origin`.

> **Dica:** Se você quiser que a pasta local tenha um nome diferente do repositório no servidor, basta passar o nome desejado no final do comando:
> ```bash
> $ git clone git@github.com:dono-original/repositório.git <seu-diretório-customizado>
> ```

### 2.2 A Diplomacia do Código: Git Fork

O *Fork* é um conceito que confunde muita gente porque, assim como o Pull Request, ele **não é um comando do Git**, mas uma funcionalidade das plataformas (GitHub/GitLab).

### 2.2.1 Por Que Não Posso Apenas Clonar?

Se você tentar clonar o repositório oficial do *Linux* ou do *VS Code* e der um `git push`, você receberá um erro de permissão. Ou você achava que baixar o código base na sua máquina tornaria você o dono de tudo? Haha, não, não. Você não é o dono desses projetos. MAS, o **Fork** resolve isso criando uma **cópia idêntica** do repositório da **sua conta**.

### 2.2.2 O Fluxo do Contribuidor

O caminho para se tornar um desenvolvedor respeitado no mundo Open Source segue este roteiro:

1. Você faz um **Fork** do projeto original para a sua conta (via GUI);
2. Você faz um `git clone` do seu fork para a sua máquina;
3. Você cria uma branch, faz as melhorias e dá o `git push` para o **seu fork**;
4. Você abre um Pull Request do seu fork para o projeto original e reza pra que seja aceito e dado `merge`. 

Ter uma contribuição direta em um projeto Open Source é um grande marco na carreira de um desenvolvedor.

### 2.3 Mantendo o Vínculo: O Remoto "Upstream"

Quando você faz um fork, o seu repositório na nuvem fica "desconectado" do original. Se o dono do projeto original fizer atualizações, o seu fork não vai recebê-las automaticamente. Para resolver isso, configuramos um segundo remoto chamado convencionamente de `upstream`.

```bash
# O "origin" é o SEU fork 
# O "upstream" é o projeto ORIGINAL de onde você veio

$ git remote add upstream git@github.com:dono-original/repositório.git
```

Agora, você pode buscar as novidades do original sempre que quiser:

```bash
$ git fetch upstream
$ git merge upstream/main
```

### 2.4 Clone HTTPS vs. SSH: A Escolha Profissional

Você verá dois tipos de links para clonar um repositório, no GitHub ou GitLab.

- **HTTPS:** Pede senha/token o tempo todo. É pra quem gosta de sofrer.
- **SSH:** É o que você vem aprendendo a fazer desde o Volume I, usando as chaves SSH que configuramos. É seguro, rápido e silencioso.

Como você está lendo este manual, é presumido que você escolheu o caminho da eficiência. Use sempre o link que começa com `git@github.com...`, e seja feliz.
