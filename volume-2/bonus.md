\newpage

# Capítulo Bônus
\vspace{-1em}
## A Customização do Terminal
\vspace{1em}

Promessa é dívida. No fim do Volume I, foi dito que o terminal não precisava ser um abismo preto e branco, e sem vida (a não ser que você o queira assim). Agora que você já entende como o Git funciona sob o capô, vamos transformar a sua ferramenta de trabalho em uma extensão do seu cérebro. Um terminal bem configurado não é apenas "bonito"; ele fornece feedback visual instantâneo, além de ensinar lógica de terminal, a medida que você aumenta sua coleção de plugins instalados.

### 7.1 O Alicerce: Nerd Fonts

Antes de qualquer coisa, você precisa de uma fonte que entenda o "dialeto" moderno. O *Oh-My-Zsh* e, principalmente, o tema que usaremos abaixo, exigem icones que fontes comuns não possuem. As Nerd Fonts são versões de fontes famosas (como JetBrains Mono ou Fira Code, que também são fortemente recomendadas por este manual) que incluem milhares de glifos.

**Como instalar:**

1. Vá ao site nerdfonts.com;
2. Recomenda-se a **MesloLGS NF** (otimizada para o Powerlevel10k) ou a **JetBrainsMono Nerd Font**;
3. No seu terminal (Mac, Linux, Termux ou WSL), muda a fonte nas configurações para a versão "Nerd Font".

### 7.2 o Framework: Oh-My-Zsh 

O Oh-My-Zsh é o framework mais popular para gerenciar sua configuração do Zsh. Ele vem com centenas de plugins e temas que transformam o shell básico em uma estação de trabalho profissional customizada.

### 7.2.1 Identificando seu Shell (Para sua Sanidade)

Antes de sair disparando comandos de instalação como um alucinado, você precisa garantir que está realmente no ambiente Zsh. Tentar instalar o Oh-My-Zsh dentro do Bash ou Fish é o caminho mais curto para você perder a paciência com erros de sintaxe irritantes e largar o terminal.

Para descobrir qual é o seu shell atual, digite:

```Bash
$ echo $SHELL 
```

Se a resposta for algo como `/bin/zsh` ou `/usr/bin/zsh`, você está pronto para o próximo passo. Se aparecer `/bin/bash` ou `/bin/fish`, você precisa mudar seu shell padrão primeiro, geralmente com o comando:

```bash
$ chsh -s $(which zsh)
```

### 7.2.2 Instalando o Oh-My-Zsh

```bash
$ sh -c "$(curl -fsSL \
    (https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Sim, esse passo é só isso mesmo.

### 7.3 A Estética de Elite: Powerlevel10k (p10k)

Se o Oh-My-Zsh é o motor, o *Powerlevel10k* é a carenagem.

### 7.3.1 Instalando o Tema 

```bash
$ git clone --depth=1 \
    https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```

Depois, edite seu `~/.zshrc` e confirme a mudança na linha que define o tema do shell: `ZSH_THEME` para `ZSH_THEME="powerlevel10k/powerlevel10k"`. Por fim, atualize o shell com `source ~/.zshrc`.

```Bash
# Se você usa o Neovim:
$ nvim ~/.zshrc

# Caso contrário, use o comando "nano" para editar:
$ nano ~/.zshrc

# Mude a linha que contém "ZSH_THEME" para:
$ ZSH_THEME="powerlevel10k/powerlevel10k"

# Salve e saia do editor. Em seguinda atualize o shell:
$ source ~/.zshrc
```

Com isso, o configurador do p10k irá inicializar e você só precisa seguir as instruções que aparecerão no terminal para concluir. Não ficou satisfeito com o resultado? Basta digitar `p10k configure`, começar o processo outra vez para alterar o que você não gostou e salvar a nova customização. Agora seu terminal tem outra cara.

### 7.4 Outros Plugins Indispensáveis

Para o terminal ser inteligente, você precisa destes dois plugins instalados:

```bash
# Autosuggestions:
$ git clone \
    https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax Highlighting:
$ git clone \
    https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Novamente, no seu `~/.zshrc`, confirme a ativação dos plugins na lista `plugins=(git zsh-autosuggestions zsh-syntax-highlighting)` e atualize o shell com `source ~/.zshrc`.

Ter um ambiente que você gosta de olhar torna as horas de estudo menos exaustivas. O Powerlevel10k dará o status do Git em tempo real na sua cara. Use essa informação para ser um desenvolvedor mais atento.
