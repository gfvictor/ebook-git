\newpage

# Capítulo VI
\vspace{-1em}
## Cheat Sheet
\vspace{1em}

Se você é como a maioria dos mortais (ou apenas um estudante de computação com a memória cheia de outras matérias), vai esquecer os comandos básicos em algum momento.

Este capítulo é seu guia de consulta rápida. Não se sinta mal por olhar aqui, até os desenvolvedores sêniors fazem isso quando ninguém está olhando.

**Comandos de Configuração e Início:**

| ***Comando***                          | ***O Que Ele Faz***                                    |
|----------------------------------------|--------------------------------------------------------|
| `git config --g user.name "Nome"`      | Define quem leva a culpa do código                     |
|                                        |                                                        |
| `git config --g user.mail "email"`     | Onde os outros vão te cobrar explicações               | 
|                                        |                                                        |
| `git init`                             | Transfroma uma pasta comum em um repositório sagrado   |


**O Ciclo de Vida:**

| ***Comando***                          | ***Função***                                           |
|----------------------------------------|--------------------------------------------------------|
| `git status`                           | Te diz o que está em qual lugar. Seu melhor amigo      |
|                                        |                                                        |
| `git add <arquivo>`                      | Coloca o item no "carrinho de compras" (Staging Area)  |
|                                        |                                                        |
| `git add .`                            | Adiciona tudo o que você mexeu (Cuidado!).             |
|                                        |                                                        |
| `git commit -m "mensagem"`             | Tira a foto oficial do seu progresso.                  |
|                                        |                                                        |
| `git log --oneline`                    | A história resumida do seu projeto pra quem tem pressa |

**A Máquina do Tempo:**

| ***Comando***                          | ***Nível de Perigo***                                  |
|----------------------------------------|--------------------------------------------------------|
| `git restore <arquivo>`                | Desfaz a última bagunça local. (Baixo)                 |
|                                        |                                                        |
| `git reset --soft HEAD~1`              | Desfaz o último commit, mas guarda o código. (Médio)   |
|                                        |                                                        |
| `git reset --hard <hash do commit>`    | Apaga o presente e volta ao passado. (Nuclear!)        |
|                                        |                                                        |
| `git commit --amend`                   | "Tapinha" no último commit para esconder um erro. (Ok) |

**O Multiverso:**

| ***Comando***                          | ***Utilidade***                                        |
|----------------------------------------|--------------------------------------------------------|
| `git branch`                           | Lista as realidades paralelaa disponíveis.             |
|                                        |                                                        |
| `git branch <nome>`                    | Cria uma nova linha temporal sem sair da atual.        |
|                                        |                                                        |
| `git switch <nome>`                    | Pula de uma realidade para outra instantaneamente.     |
