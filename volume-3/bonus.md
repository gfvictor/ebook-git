\newpage

# Capítulo Bônus
\vspace{-1em}
## O Cadeado Verde - Assinando seus Commits
\vspace{1em}

Você já reparou naquele selo **"Verified"** verdinho do lado de alguns commits no GitHub? E já se tocou de que qualquer
pessoa pode fazer um commit com o seu nome e o seu e-mail? Pois é. O `git config user.name` é só um campo de texto: ele
não prova absolutamente nada. Neste bônus, você vai fechar essa brecha assinando criptograficamente o que você commita.

### B.1 Por que Assinar

O nome e o e-mail de um commit são preenchidos por quem commita, sem nenhuma verificação. Eu posso clonar um projeto,
rodar `git config user.email "email-do-seu-chefe@empresa.com"` e commitar como se fosse ele. Em projetos open source e
em empresas que levam *supply chain* a sério, isso é um problema concreto.

A assinatura resolve: o commit passa a carregar uma prova matemática de que foi feito por quem diz tê-lo feito. O GitHub
valida essa prova e estampa o **"Verified"**.

### B.2 Dois Caminhos: GPG ou SSH

Antigamente, só dava para assinar com GPG, que é poderoso e chato de configurar. Desde o Git 2.34, você pode assinar com
a **mesma chave SSH** que já usa para autenticar (aquela do Volume I). É o caminho mais simples, e é o que vamos seguir
aqui. Quem já tem um fluxo GPG montado pode continuar nele sem problema.

### B.3 Configurando a Assinatura por SSH

Assumindo que você já tem um par de chaves em `~/.ssh/id_ed25519` (se não tem, volte ao Volume I, Capítulo II):

```bash
# Diz ao Git para assinar com SSH em vez de GPG
$ git config --global gpg.format ssh

# Aponta para a sua chave pública
$ git config --global user.signingkey ~/.ssh/id_ed25519.pub

# Assina todos os commits automaticamente
$ git config --global commit.gpgsign true

# (Opcional) assina também as tags
$ git config --global tag.gpgsign true
```

### B.4 Registrando a Chave no GitHub

A mesma chave pública serve para duas coisas no GitHub, mas você precisa cadastrá-la **duas vezes**:

1. Vá em *Settings -> SSH and GPG keys -> New SSH key*;
2. No campo **Key type**, escolha **Signing Key** (e não "Authentication Key");
3. Cole o conteúdo de `~/.ssh/id_ed25519.pub`.

Se você já tinha essa chave cadastrada como *Authentication Key*, cadastre de novo como *Signing Key*. São dois
registros separados.

### B.5 Verificando Localmente

Para o seu Git conseguir dizer "esta assinatura é de fulano", ele precisa de uma lista de assinantes confiáveis:

```bash
$ mkdir -p ~/.config/git
$ echo "seu-email@provedor.com $(cat ~/.ssh/id_ed25519.pub)" \
    >> ~/.config/git/allowed_signers
$ git config --global gpg.ssh.allowedSignersFile ~/.config/git/allowed_signers
```

Agora confira:

```bash
$ git commit -m "feat: primeira mensagem assinada"
$ git log --show-signature -1
```

Você deve ver uma linha `Good "git" signature for seu-email@provedor.com`.

### B.6 A Recompensa

A partir daqui, todo commit e toda tag saem assinados sem que você faça nada. No GitHub, os seus commits ganham o selo
**"Verified"**. Em projetos sérios, isso deixa de ser enfeite: muitos exigem *"Require signed commits"* no branch
protection, e, sem assinatura, o seu merge simplesmente não acontece.

Pequeno esforço de configuração, feito uma vez só. Prova de autoria, para sempre.
