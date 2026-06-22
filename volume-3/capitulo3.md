\newpage

# Capítulo III
\vspace{-1em}
## Pilhagem e Arrependimento - Cherry-pick e Revert
\vspace{1em}

Chegamos a um ponto de desenvolvimento em que fazer um `git merge` ou um `git rebase` inteiro é o mesmo que usar uma
bazuca para matar um mosquito. Às vezes, você não quer a branch inteira do seu colega; você quer apenas *aquele* commit
específico que resolve o seu problema imediato.

Outras vezes, o desastre já foi enviado para a branch `main` pública. Você não pode reescrever a história com um `git
reset` sem causar a Terceira Guerra Mundial no escritório. Você precisa de um botão de desfazer que seja educado e
auditável.

Para a cirurgia de precisão e para o perdão corporativo, o Git nos dá a pilhagem e o arrependimento.

### 3.1 A Pilhagem Perfeita: `git cherry-pick`

Imagine o cenário: o seu colega está trabalhando há três semanas numa branch obscura chamada `feature/payment-gatewau`.
No meio dessa bagunça inacabada, ele sem querer conserta um bug crítico de segurnça no login. Você, que está cuidando do
lançamento hoje, precisa urgentemente desse conserto na `main`, mas não pode fazer o `merge` da branch dele porque o
gateway de pagamento ainda quebra o sistema inteiro.

É aqui que você coloca seu chápeu de pirata e usa o `git cherry-pick`.

O `git cherry-pick` permite que você extraia as alterações de um commit específico de qualquer lugar do repositório e
aplique direto na sua branch atual, deixando o resto do lixo pra trás.

### 3.1.1 Executando o Roubo

Primeiro, você descobre qual é o hash do commit milagroso lá na branch do seu colega (usando o `git log`). Vamos dizer
que seja `a1b2c3d`.

Lembre-se da regra suprema da colaboração: nós nunca commitamos diretamente nas branches protegidas (`main` ou `dev`).
Portanto, vá para a sua branch base, atualize-a, e crie uma branch isolada para a sua missão de resgate:

```bash 
$ git switch dev
$ git fetch
$ git pull                               # Se necessário
$ git switch -c hotfix/login-security
```

Agora que você está em território seguro e isolado, execute a extração:

```bash
$ git cherry-pick a1b2c3d
```

Pronto. O Git pega a "diferença" daquele commit isolado e gera um **novo commit** na sua nova branch `hotfix`, mantendo
o mesmo autor e mensagem originais. Agora basta você dar um `git push` dessa branch, abrir o Pull Request, salvar a
produção e ignorar completamente o resto do código quebrado do seu colega.

### 3.1.2 O Perigo do "Fogo Amigo"

O `git cherry-pick` é viciante, mas ele esconde uma armadilha corporativa. Ele não apenas copia o código, ele **duplica
o histórico**. Ao roubar o commit do seu colega, você gera um novo hash na sua branch.

Se você estiver "roubando" de uma branch de *hotfix* que já foi merta ou de uma biblioteca abandonada, tudo bem. Mas se
você usar o `git cherry-pick` para puxar um código de uma **branch de feature ativa** do seu colega (um código que ainda
não foi aprovado num Pull Request), tome muito cuidado.

Se o seu colega precisar alterar aquele código de novo antes de enviar, e você já tiver injetado a versão antiga dele na
`main`, quando os dois tentarem abrir seus respesctivos Pull Requests, o Git vai entrar em parafuso com códigos
conflitantes vindos de locais e hashes diferentes. O `git cherry-pick` irresponsável gera Fogo Amigo na hora do Merge.

> **Nota do Autor:** Como usar o `git cherry-pick` de forma tática para fugir de bloqueios no meio do desenvolvimento,
> sem gerar conflitos de PR e limpando a sujeira depois, é uma arte que vai além do nível avançado. Discutiremos a fundo
> no Volume IV: Vida Real.
