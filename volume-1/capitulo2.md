\newpage

# Capítulo II
\vspace{-1em}
## Preparando a Máquina
\vspace{1em}

Não se constrói nada que preste com ferramentas cegas. Antes de iniciarmos a manipulação de repositórios e a gestão de *snapshots*, precisamos garantir que o seu ambiente de desenvolvimento esteja configurado com precisão cirúrgica.

Muitos desenvolvedores iniciantes pulam esta etapa ou utilizam configuração padrão que, mais tarde, resultam em commits com nomes de usuário genéricos como "admin" ou "root", destruindo qualquer possibilidade de auditoria séria no projeto. Neste capítulo, vamos garantir que sua identidade digital seja tão sólida quanto o código que você pretende escrever.

### 2.1 A Escolha da Interface: Por Que o Terminal?

Embora existam dezenas de clientes de interface gráfica (GUIs) para o Git (GitKraken, Sourcetree ou até plugins visuais do VS Code), este manual foca exclusivamente na Interface de Linha de Comando (CLI), e eu espero que, até o final do guia, você perca o medo do terminal e passe a usá-lo com mais frequência.

Mas, por que ser tão radical?

1. **Universalidade:** O terminal funciona em qualquer servidor via SSH, onde muitas vezes não há interfaces gráficas disponível;
2. **Poder e Precisão:** Muitos comandos avançados e flags de depuração só estão disponíveis via CLI. O uso de GUIs muitas vezes "esconde" o que o Git realmente está fazendo por baixo dos panos;
3. **Velocidade:** Uma vez que os comandos entram na sua memória muscular, você se torna drasticamente mais rápido que qualquer usuário de mouse;
4. **Custo de Processamento:** Diferentemente de GUIs, que muitas vezes ocupam bastante memória e carga processual apenas em abrir e executar comandos básicos, o terminal é muito mais leve, com um custo mínimo. Você vai estar fazendo um favor para sua máquina.
5. **BÔNUS:** Vamos ser sinceros aqui - quem usa o terminal pra resolver qualquer coisa passa muito mais credibilidade, seja qual for o ambiente. Você vai ser visto de outra forma, isso é garantido.
Alguns pacotes vão estar disponíveis no Capítulo Bônus para você ter mais interesse no terminal e se habituar com seu uso diário.

### 2.2 Instalando o Git em Diferentes Ecossistemas

O Git é uma ferramenta onipresente, mas sua instalação varia conforme o sistema operacional que você escolheu para trabalhar.

### 2.2.1 Ambiente Linux e Termux (Android)

No ecossistema baseado em Debian/Ubuntu, o gerenciador de pacotes `apt` é o padrão. No Termux (se você gosta de desenvolvimento em mobilidade extrema, em ambiente Android), utilizamos o `pkg`.

Atualizando os repositórios antes da instalação:
```bash
$ sudo apt update             # No Ubuntu/Debian
$ pkg update && pkg upgrade   # No Termux
```

Instalando o Git:
```bash
$ sudo apt install git        # No Ubuntu/Debian
$ pkg install git             # No Termux
```

### 2.2.2 MacOS

Para usuários de Mac, o instalador costuma vir com o Xcode CL Tools, mas para garantir a versão mais recente e facilitar atualizações futuras, o Homebrew é o padrão do mercado. E se você tem Mac e não sabe o que é Homebrew... Jovem, vá ao site oficial do projeto e instale na sua máquina pra ontem.

O comando é simples:
```bash
$ brew install git
```

### 2.2.3 Windows e o WSL2

No Windows, embora exista o *Git for Windows*, recomenda-se fortemente o uso de WSL2 (Windows Subsystem for Linux). Isso permite que você execute um ambiente Linux real dentro do Windows, e consiga executar os comandos normalmente, sem adaptações bizarras.

### 2.3 Identidade e Rastreabilidade

O Git é, em sua essência, um sistema de auditoria. Ele precisa saber quem é você para carregar esses metadados em cada alteração. Se você não configurar isso, o Git tentará "adivinhar" com base no seu usuário do sistema, o que geralmente termina em um histórico de commits confuso e pouco profissional.

Configure seu nome e e-mail globalmente (isso será aplicado a todos os seus projetos futuros):

```bash
$ git config -g user.name "Victor Gama de Farias"
$ git config -g user.email "seu.email@provedor.com"
```

### 2.3.1 O Editor de Mensagens

Quando você executa um commit sem a flag `-m`, o Git abre o editor padrão do sistema. Para evitar ficar "preso" em um editor que você não domina, defina o seu favorito. Como bons amigos do terminal (ao ainda chegando lá), o NeoVim (ou nvim) é a escolha lógica pela sua eficiência e leveza. Mas **ATENÇÃO, se você nunca usou o nvim, primeiro procure um tutorial próprio ou a documentação oficial**, porque ele não vai ser detalhado aqui, pra que não fujamos do assunto principal. Dito isso:

```bash
$ git config -g core.editor "nvim"    # Ou outro editor qualquer
```

### 2.4 Autenticação com Chaves SSH (Segurança Avançada)

Trabalho com HTTPS e ficar digitando tokens de acesso pessoal a cada `git push` não é nada produtivo. Desenvolvedores profissionais utilizam chaves SSH (Security Shell). Isso permite que sua máquina converse com provedores como GitHub ou GitLab de forma segura, criptografada e, acima de tudo, automática.

### 2.4.1 Gerando um Par de Chaves Ed25519

Calma, é só o nome do algoritmo que iremos usar. Atualmente, o algoritmo Ed25519 é o mais recomendado por ser mais rápido e seguro que o antigo RSA. Para gerar sua chave no terminal, use:

```bash
$ ssh-keygen -t ed25519 -C "seu.email@provedor.com"
```

Ao rodar o comando acima, o terminal solicitará um local para salvar. Apenas precisone `Enter` para aceitar o padrão `(~/.ssh/id_ed25519)`. Ao final, você verá uma "arte aleatória" em ASCII (que eu sei que você já está começando a gostar), que confirma a criação da chave:

```bash
Generating public/private ed25519 key pair.
    +--[ED25519 256]--+
    |    o.o.         |
    |      .oo.       |
    |     . oo .      |
    |       o . .     |
    |    S .. o       |
    |   ..   . .      |
    |      . . .. .   |
    |      .  . .     |
    |    . . .        |
    +----[SHA256]-----+
```

### 2.4.2 Adicionando a Chave ao Agente e ao Provedor

Para que o sistema gerencie sua chave e você não precise digitar a senha da chave a todo momento, inicialize o agente:

```bash
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/id_ed25519
```

Agora, você deve copiar o conteúdo da sua **chave pública** (o arquivo termina em `.pub`,  pelo amor de Deus) e colá-lo nas configurações da sua conta no GitHub - geralmente em *Settings > SSH and GPG keys*):

```bash
$ cat ~/.ssh/id_ed25519.pub
```

> **Lembrando:** Nunca compartilhe sua **chave privada** (o arquivo sem a extensão `.pub`). Ela é o seu segredo de acesso.

### 2.5 Resumo das Configurações

Para garantir que tudo está correto, você pode listar todas as suas configurações do Git com o comando:

```bash
$ git config --list
```

Isso exibirá uma lista com o seu nome, e-mail e editor configurados. Se você chegou até aqui, sua "máquina de guerra" está pronta para o primeiro projeto real. No próximo capítulo, sairemos da teoria de configuração e entraremos na prática de criação de repositórios.
