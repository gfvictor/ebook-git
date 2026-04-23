\newpage

# Capítulo Bônus
\vspace{-1em}
## Terminal Além do Git
\vspace{1em}

Como prometido no início, não vou deixá-los apenas com o Git. Um bom ferreiro conhece o metal, mas um mestre conhece suas ferramentas. Se você vai passar horas no terminal (eu espero!), que seja em um ambiente que não agrida seus olhos e que potencialize sua produtividade.

Abaixo, foi selecionado um "Kit Básico" para transformar seu terminal - seja no Termux, Linux ou MacOs - em uma ferramenta que te atraia para o uso dela.

### B.1 Fastfetch: O RG do Sistema

O antigo **Neofetch** foi descontinuado, e como bom entusiasta, é bom usar o que há de mais moderno. O `fastfetch` exibe as informações do seu sistema com um logo ASCII (que você já deve adorar). É puramente estético? Sim. Mas é sempre agradável ver o logo do seu sistema operacional, com seu uptime e endereço de IP estampados no terminal, nas horas livres.

```bash
$ pkg install fastfetch     # Termux
$ apt install fastfetch     # Linux
$ brew install fastfetch    # MacOs

$ fastfetch                 # para executar
```

### B.2 Btop: O Painel de Controle

O comando `top` padrão é feio, rude e confuso. O `btop` é um monitor de recursos (CPU, RAM, Rede, Discos) que parece ter saído de um filme de ficção científica. Ele é essencial para monitorar quais processos ou programas estão derrentendo o processador do seu dispositivo.

```bash
$ pkg install btop
$ apt install btop
$ brew install btop

$ btop
```

### B.3 Eza e Bat: O Upgrade dos Clássicos

Por que usar comandos de 1970 se podemos ter cores e ícones?

- Eza: Um substituto moderno para o comando `ls`. Ele lista arquivos com cores, ícones e informações de Git integradas. Que conveniente.

```bash
$ pkg install eza 
$ apt install eza
$ brew install eza

# Crie um *alias* para evitar escrever o comando toda vez
$ eza -a --icons=always --color=always --grid
```

- Bat: Um substituto para o `cat` que adiciona numeração de linhas e realce de sintaxe para *quase* todas as linguagens.

```bash
$ pkg install bat 
$ apt install bat
$ brew install bat

$ bat nome-do-arquivo
```

Esses são os pacotes desse volume. No Capítulo Bônus do Volume II, você vai aprender a customizar visualmente o seu terminal. Então vai criando o costume de usar o terminal para suas tarefas diárias.
