\newpage
\pagenumbering{Roman}
\pagestyle{plain}

### Prefácio

Bem vindos. Se você chegou até aqui e sobreviveu aos Volumes I e II
sem deletar o próprio repositório por engano (ou sem culpar outra
pessoa por isso), mais uma vez, parabéns. Você já não é mais um risco
imediato para a sociedade do desenvolvimento de software. Você sabe
como comitar, sabe como colaborar e, o mais importante, sabe como não
entrar em pânico quando vê um conflito de merge.

Mas a vida real não é apenas sincronizar código. A vida real, meu
jovem, é auditoria. É descobrir quem introduziu aquele bug às 3h da
manhã de um sábado. É recuperar aquele commit que você **achou** que
não precisava mais e apagou com um `reset --hard` incosequente. É
gerenciar múltiplas frentes de trabalho sem fazer do seu diretório
local uma zona de guerra.

Neste Volume III - Engenharia de Fluxo e Auditoria - vamos deixar de
lado as ferramentas de pedreiro e pegar o bisturi.

### O Que Você Vai Aprender Desta Vez

Este manual não é para os fracos de coração. Prepare-se para dominar:

1. **Cirurgia de Histórico:** Como reescrever o passado para parecer
   que você nunca errou com `rebase -i` e como usar a rede de
   segurança definitiva para salvar sua pele com `reflog`;
2. **Auditoria e Debugging:** Ferramentas para encontrar
   cirurgicamente o exato momento em que tudo deu errado, usando
   `bisect` e quem foi o culpado, com `blame` (importantíssimo!);
3. **Pilhagem de Commits:** Como pegar apenas o que importa de outras
   frentes com `cherry-pick` e como desfazer besteiras de forma
   elegante, usando `revert`;
4. **Gerenciamento de Contexto:** A evolução do paleolítico `stash`
   para a elegância do `worktree`;
5. **Automação:** Como impedir que código lixo chegue ao repositório
   usando Git Hooks.

### Metodologia de Estudo

Como dito em todos os volumes, somente a leitura deste e de outros
materiais não é o sufiente, **a prática é o que fará você aprender de
verdade e evoluir como desenvolvedor**.

Até agora, foi ensinado como trabalhar em projetos sem quebrá-lo. A
partir desse ponto, este volume vai te ensinar a *quebrar* o histórico
de propósito e a consertá-lo antes de que alguém perceba. Mas
lembre-se: com grandes poderes, vem uma grande chance de você destruir
o repositório inteiro. Vamos prosseguir com cautela e sabedoria.

Apertem os cintos. A fundação de aço que construímos desde o Volume I
está prestes a ser testada.
