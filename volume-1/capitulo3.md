\newpage

# Capítulo III
\vspace{-1em}
## O Nascimento de um Repositório
\vspace{1em}

Neste capítulo, saíremos da inércia das configurações e daremos vida ao seu primeiro projeto controlado pelo Git. Entender como um diretório comum se transforma em um repositório é fundamental para compreender a árvore de objetos que o Git constrói por trás dos panos.

### 3.1 O Comando `git init`

Tudo começa com um comando simples, mas poderoso. O `git init` é o responsável por criar a estrutura necessária para o rastreamento. Ao executá-lo, o Git cria um subdiretório oculto chamado `.git`.

> **Atenção:** Nunca apague a pasta `.git` a menos que você queira destruir todo o seu histórico do seu projeto. Ela é o "cérebro" do repositório.

```bash
$ mkdir nome do projeto
$ cd nome do projeto
$ git init
```
Ao rodar isso, você verá uma mensagem parecida com: `Initialized empty Git repository in /home/username/nome-do-projeto/.git/`

### 3.2 O Sentinela: `git status`

Se existe um comando que você digitará milhares de vezes por dia (se você trabalhar diariamente com projetos), é o `git status`. Ele é seu GPS. Ele te diz exatamente em qual área - Working, Directory ou Staging Area - seus arquivos estão e se há algo que o Git ainda não reconhece.

```bash
$ git status
```

Como o repositório está vazio, o Git informará que não há nada para commitar e que você está na branch principal (geralmente `main` ou `master`).

### 3.3 Ciclo de Vida dos Arquivos

Para ocupar as páginas deste manual e a sua mente, precisamos detalhar o que acontece quando criamos um arquivo. Vamos criar um arquivo de exemplo chamado `README.md`, dentro do seu projeto. Dentro da pasta do projeto, digite:

```bash
$ echo nome-do-projeto > README.md
$ git status
```

Agora, o `git status` mostrará o arquivo em vermelho, sob o título "Untracked files". Isso significa que o arquivo existe no seu disco, mas o Git o ignora completamente. Ele ainda não faz parte do sistema.

### 3.4 A Área de Preparação (Staging Area)

Aqui é onde muitos iniciantes se confundem. O Git não tira a "foto" (*snapshot*) diretamente do seu diretório de trabalho. Você precisa "preparar" os arquivos para o commit. É como se você estivesse escolhendo quem vai aparecer na foto oficial do time.

Para adicionar o arquivo à Staging Area:

```bash
$ git add README.md
```

Agora, ao rodar `git status`, o arquivo aparecerá em verde. Ele está pronto pra ser consolidado.

### 3.5 O Primeiro *Snapshot*: `git commit`

O commit é o momento em que você grava o estado atual dos arquivos preparados no banco de dados do Git. Cada commit deve ser acompanhado de uma mensagem clara e consisa.

```bash
$ git commit -m "Initial commit: Adicionando o README do projeto"
```

> **Dica:** Mensagens ambíguas de commit como "ajustes", "fix" ou até "..." são o sinal mais claro de um desenvolvedor amador. Seja descritivo. Quem quer que vá acompanhar seu projeto, ou até você mesmo, no futuro, vai agradecer quando precisar fazer um rollback em caso de necessidade.

> Você verá alguns padrões auto-impostos no decorrer da sua jornada como desenvolvedor, e muitas não farão sentido. Contudo, um padrão interessante é o padrão "**feat - chore - fix**":

- Para commits contendo novos recursos, comece com `feat: adicionado componentes de login`;
- Commits com desenvolvimento de recursos existente, mensagens como `chore: deletado boilerplate padrão não usado` são um exemplo;
- E por fim, commits que detalham consertos, você pode escrever como `fix: formatado logo e fonte`.

> Como dito antes, esse "padrão" é auto-imposto e você só precisa segui-lo se realmente quiser, mas fica aqui como uma dica.

### 3.6 Visualizando a História: `git log`

Como saber o que foi feito? O comando `git log` exibe a linha do tempo do seu projeto, mostando o autor, a data e o **Hash SHA-1** (o identificador único, que ainda vamos abordar no tema seguinte) de cada commit.

```bash
$ git log
```

Este comando será seu maior aliado para entender a evolução do software e para rastrear quando um bug específico foi introduzido no sistema. No próximo capítulo, você vai entender a importância dele e aprender um truque que vai ajudar bastante.
