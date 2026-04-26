\newpage

# Capítulo VI
\vspace{-1em}
## Fluxos de Trabalho e Pulls Requests
\vspace{1em}

Se você chegou aqui, você já domina a técnica (ou pelo menos conhece). Agora, vamos aprender a **cultura**. No mundo profissional, você raramente terá permissão para dar um `git push` direto na branch pricipal (`main`). O código passa por um funil de qualidade e diplomacia técnica chamado **Pull Request** (ou PR, para os íntimos) no GitHub, ou **Merge Request (MR) no GitLab.

### 6.1 O Que é um Pull Request?

A primeira coisa que você precisa entender é: o Pull Request **não é um comando Git**. Ele é um recurso das plataformas de hospedagem que serve comom um "fórum de discussão" sobre um conjunto de alterações. É o momento em que você diz ao time: "Galera, eu terminei a funcionalidade *x* na minha branch. Por favor, alguém revise o que eu fiz e, se estiver tudo certo, junte ao resto do projeto principal". 

O PR é onde o código deixa de ser um "segredo seu" e passa a ser propriedade intelectual da organização. É o ponto de controle onde erros de lógica, falhas de segurança e código mal escrito são barrados antes de chegarem ao usuário final.

### 6.2 O Fluxo Profissional (GitHub Flow)

Trabalhar em equipe exige um ritmo. E não estamos falando de energias boas ou outra bobagem do tipo, mas um fluxo que quase todas as empresas modernas usa, que é uma variação do **GitHub Flow**, focado em branches curtas e entregas frequentes:

1. **Criação da Branch:** Nunca mexa na `main`. Crie branches semânticas: `git switch -c feat/xxxx` (sim, você pode criar branches com `git switch` com a flag `-c`. Ou você pode continuar usando `git checkout`);
2. **Trabalho Local:** Faça commits atômicos (pequenos), organizados e com mensagens decentes. Não precisam ser detalhadas, mensagens curtas e condizentes às mudanças do conteúdo são melhores;
3. **Envio para o Remoto:** Suba seua branch para o servidor: `git push -u origin feat/xxxx`;
4. **Abertura do PR:** Mande o seu trabalho concluído para a análise e revisão dos seus pares. Se quiser usar o terminal para essa etapa, em vez do GitHub, use a CLI para não perder o foco (veja o tópico 6.3);
5. **Revisão e Discussão:** Seus coleguinhas revisam o código e sugerem melhorias ou correções;
6. **O Merge:** Após a aprovação e a passagem nos testes automatizados (que normalmente existem em projetos sérios), o código é fundido à `main`.

Siga essas etapas e vai dar tudo certo. Seus colegas não falarão mal de você nas reuniões que você não estiver presente.

### 6.3 Soberania do Terminal: GitHub CLI (`gh`)

Para manter a filosofia de "o mouse é o inimigo", você precisa dominar o **GitHub CLI**. Ele permite gerenciar PRs, issues e até forks sem sair do seu NeoVim ou do seu Termux.

### 6.3.1 Instalando o `gh`

```bash
# No macOS:
$ brew install gh 

# No Linux (Debian/Ubuntu):
$ sudo apt install gh

# No Termux:
$ pkg install gh 
```

Após instalar, para autenticar:

```bash
$ gh auth login
```

### 6.3.2 Abrindo um PR pelo Terminal

Esqueça abrir o Chrome, Firefox ou Brave. Com sua branch já no servidor, basta digitar:

```bash
$ gh pr create --title "feat: add login components" --body "Initial implentation"
```

### 6.3.3 Listar e Revisar PRs 

```bash
$ gh pr list         # Lista os PRs abertos no projeto
$ gh pr checkout 7   # Faz o checkout direto da branch pelo ID do PR 
```

### 6.5 Etiqueta do Code Review: Deixe o Ego e a Vergonha na Porta

O **Code Review** é o processo onde outros desenvolvedores leem o seu código em busca de falhas.

- **Não é Pessoal:** As críticas são direcionadas ao seu código, não à você;
- **Responda com Código:** Se pedirem uma mudança, altere o arquivo, dê o `commit` e o `push`. O PR será atualizado instantaneamente;
- **Seja Rigoroso e Educado:** Ao revisar o código de um coleguinha, foque na qualidade técnica. Lembre-se que é um ambiente profissional.

### 6.6 Visualizado a Árvore de Commits 

A visualização da árvore de commits é algo 100% nativo do Git e muito mais potente do que qualquer plugin se você souber as flags certas. No terminal, para ver como suas branches estão convergindo ou divergindo em tempo real, usamos o `git log` com esteroides:

```bash
$ git log --graph --oneline --all --decorate
```

O que cada flag faz:

- **`--graph`:** Desenha a estrutura da árvore em ASCII (é seu tipo de arte favorito? Claro que sim);
- **`--oneline`:** Condensa cada commit em uma única linha. Essencial para árvores grandes;
- **`--all`:** Mostra todas as branches (remotas e locais), não apenas a atual;
- **`--decorate`:** Mostra onde os ponteiros das branches e tags estão apontando.

### 6.6.1 Criando um Atalho (Alias)

Como ninguém tem paciência para digitar isso toda hora, configure um apelido global diretamente no comando git:

```bash
$ git config --global alias.tree "log --graph --oneline --all --decorate"
```

Agora, basta digitar `git tree` e sentir o prazer de ver seu histórico organizado sem encostar no mouse.
