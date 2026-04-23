\newpage
\pagestyle{fancy}
\pagenumbering{arabic}
\setcounter{page}{1}
\fancyhead[R]{\textit{Volume I: Iniciante}}

# Capítulo I
\vspace{-1em}
## A Gênese do Controle de Versão
\vspace{1.5em}

### **1.1 O Abismo do "Trabalho_Final_v2_revisado.zip"**

Antes de falarmos de comandos, precisamos falar de trauma. Todo desenvolvedor iniciante já passou pela fase de copiar pastas inteiras para criar "*backups*". Esse método, carinhosamente chamado de "Descontrole de Versão", é o caminho mais rápido para a insanidade.

O problema não é apenas guardar o código, mas saber QUEM guardou, O QUE mudou, QUANDO mudou e, principalmente POR QUE diabos aquela alteração foi feita. Sem um sistema formal, o desenvolvimento colaborativo é apenas um caos organizado onde o último a salvar o arquivo ganha a briga e quem perde, além de perder o arquivo, perde tempo também.


### **1.2 O Surgimento do Git**

Em 2005, num passado não tão distante, Linus Torvalds (sim, o mesmo do Linux) estava insatisfeito com as ferramentas de versionamento da época. Ele precisava de algo que fosse:

- **Rápido:** O processamento de milhares de arquivos não poderia levar minutos;
- **Distribuído:** Todo desenvolvedor deveria ter o histórico completo, não dependendo de um servidor central o tempo todo;
- **Íntegro:** O sistema precisava garantir que o código não seria corrompido silenciosamente.

Assim nasceu o Git. Ele não foi desenhado para ser *amigável*, ele foi desenhado para ser eficiente e à prova de falhas. Existem opções mais "bonitinhas", como o GitKraken, que é um cliente GUI com uma camada cosmética mais agradável rodando sobre o motor do Git, mas você está aqui pra aprender no terminal. Então anota ai e deixa pra quando estiver entendendo como esse motor funciona.


### **1.3 A Filosofia: *Snapshots*, não Deltas**

Este é um dos pontos onde você diferencia os sistemas amadores dos profissionais. Sistemas antigos (como o SVN) guardavam apenas as diferenças entre os arquivos (deltas). O Git pensa de forma diferente. "Ah, mas o Git também te mostra as diffs em cada alteração", sim, mas dá uma olhada no seguinte:

> **Conceito Chave**: O Git trata os dados como um conjunto de *snapshots* (fotografias). Cada vez que você faz um `commit`, o Git tira uma "foto" de como todos os seus arquivos estão naquele momento **E** te mostra o que foi mudado; ele não armazena o que foi mudado, mas a **nova versão inteira** (um *blob*, é o termo correto). A diff é um cálculo entre as versões e suas alterações. Se um arquivo não mudou, ele apenas aponta para o arquivo idêntico anterior.


### **1.4 A Santissíma Trindade: Os Três Estados do Git**

Para entender o Git, você precisa parar de pensar que o arquivo está "salvo" ou "não salvo". No Git, um arquivo vive em um dos três estados principais. Entender isso é o que separa quem sabe o que está fazendo de quem apenas digita comandos aleatórios e reza para não dar conflito.

1. **Modified** (Modificado): Você alterou o arquivo, mas ainda não consolidou essas mudanças no seu banco de dados. É o estado de "trabalho em progresso";
2. **Staged** (Preparado): Você marcou um arquivo modificado em sua versão atual para ir na próxima *snapshot* do commit. É como se você estivesse colocando os produtos no carrinho antes de passar no caixa;
3. **Commited** (Consolidado): Os dados estão armazenados com segurança no banco de dados local. Pronto! Aqui, a alteração é oficial e faz parte da história do projeto, ou até você fazer um rollback, mas vamos deixar isso mais pra frente e vamos entender o básico primeiro.


### **1.5 As Três Seções de um Projeto Git**

Esses estados estão diretamente ligados às três áreas onde o Git opera:

1. **Working Directory** (Diretório de Trabalho): É a cópia de uma versão do projeto que você está editando no momento. São os arquivos reais que você vê no seu explorador de arquivos ou no terminal;
2. **Staging Area** (Área de Preparação): Tecnicamente é um arquivo que armazena informações sobre o que vai entrar no seu próximo commit. É aqui que o comando `git add` faz sua mágica;
3. **Directory/Repository** (O Diretório Git): É onde o Git armazena os metadados e o banco de dados de objetos do seu projeto. É a parte mais importante, o cérebro da operação. É o que é copiado quando você faz um `git clone`.


### **1.6 O Fluxo Básico de Trabalho**

Se resumirmos o dia a dia de um desenvolvedor que não quer ser demitido por não saber o básico, o fluxo é sempre o seguinte:

- Você modifica arquivos no seu *working directory*;

- Você seleciona apenas as mudanças que deseja incluir no próximo commit, adicionando à *staging area*, com `git add`;

- Você faz o commit de fato, que pega os arquivos como estão na *staging area* e armazena aquele *snapshot* permanentemente no seu Diretório Git, usando o `git commit`.

**Ilustrando** (em ASCII, pra você acostumar com o visual do terminal):
```bash
[ Working Directory ] ----( git add )----> [ Staging Area ]
             ^                                        |
             |                                  ( git commit )
             |                                        |
             +----------( checkout / restore )--------|
                                                      v
                                             [ Git Directory ]
```
