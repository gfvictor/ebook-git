\newpage
\pagestyle{plain}

### Considerações Finais

Aqui termina a trilogia. Três volumes atrás, você estava renomeando arquivos para `trabalho_final_v2_revisado.zip` e
rezando para não sobrescrever a versão certa. Agora, você reescreve histórico com bisturi, encontra o commit que
derrubou a produção em sete passos, extrai correções cirurgicamente de branches alheias, mantém três frentes de trabalho
abertas sem stress e tem robôs barrando código ruim antes mesmo de ele existir.

Recapitulando o que este Volume III te deu:

- **`reflog` e `rebase -i`:** a rede de segurança e o bisturi do histórico;
- **`blame` e `bisect`:** as ferramentas de auditoria que encontram o culpado e o momento exato do crime;
- **`cherry-pick` e `revert`:** a pilhagem de precisão e o arrependimento elegante que não reescreve nada;
- **`stash` e `worktree`:** da fita adesiva à bancada dupla no gerenciamento de contexto;
- **Git Hooks:** os porteiros automáticos que rodam antes de cada commit;
- **CI/CD com GitHub Actions:** a linha de montagem que não aceita suborno nem `--no-verify`.

Você não "sabe Git" agora. Você **pensa** em Git. A diferença aparece na próxima vez que algo der errado (e vai dar):
você não vai entrar em pânico, vai abrir o terminal, rodar um `git reflog`, e resolver antes de o café esfriar.

### O Próximo Passo: Volume IV

Esta trilogia te ensinou os comandos e a mecânica. O que ela não cobriu foi a **política**: o que fazer quando o
`cherry-pick` que te destravou vira conflito no PR do colega três dias depois; como alinhar a ordem de merge num time de
oito pessoas; quando reescrever histórico compartilhado é aceitável e quando é motivo de demissão. Isso é assunto do
**Volume IV: Vida Real**, onde o Git encontra as pessoas, e as pessoas são sempre a parte difícil.

Continue praticando. Quebre repositórios de mentira para não quebrar os de verdade. E, principalmente: não seja a pessoa
que dá `git push --force` na `main` numa sexta-feira à noite.

### Referências Bibliográficas

1. CHACON, Scott; STRAUB, Ben. ***Pro Git***. 2. ed. Apress, 2014. Disponível em: https://git-scm.com/book

2. LOELIGER, Jon; MCCULLOUGH, Matthew. ***Version Control with Git***. 2. ed. O'Reilly Media, 2012.

3. GIT-SCM. ***Git Reference Documentation***. Disponível em: https://git-scm.com/docs Acesso em: 26 ago. 2026.

4. GITHUB. ***GitHub Actions Documentation***. Disponível em: https://docs.github.com/actions Acesso em: 26 ago. 2026.

5. ATLASSIAN. ***Advanced Git Tutorials***. Disponível em: https://atlassian.com/git/tutorials Acesso em: 26 ago. 2026.

6. CONVENTIONAL COMMITS. ***Conventional Commits 1.0.0***. Disponível em: https://www.conventionalcommits.org Acesso em: 26 ago. 2026.

7. PRE-COMMIT. ***pre-commit: A framework for managing git hooks***. Disponível em: https://pre-commit.com Acesso em: 26 ago. 2026.

8. SEMANTIC VERSIONING. ***Semantic Versioning 2.0.0***. Disponível em: https://semver.org Acesso em: 26 ago. 2026.
