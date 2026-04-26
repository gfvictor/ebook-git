\newpage

# Capitulo V
\vspace{-1em}
## A Arte da Fusão

No capítulo anterior, resolvemos crises e confltos. Agora, vamos aprender a planejar a paz. O `git merge` é muito mais do que apenas "unir arquivos"; é a ferramenta que consolida histórias divergentes. No nível intermediário, você precisa entender que nem todo `merge` é igual e que a forma como você une o seu código diz muito sobre a sua maturidade técnica como desenvolvedor.

Fusão não é apenas sobre o resultado final, mas sobre a narrativa que você deixa para quem vier depois de você (ou para o seu "eu" do futuro, daqui a dois meses, quando não se lembrar de mais nada).

### 5.1 Além do Básico: O Mecanismo do Three-Way Merge

Você já viu o conceito não-técnico do Three-Way Merge. Agora vamos entender como ele realmente funciona.

Quando você executa um `git merge`, o Git procura por um *Ancestral Comum*, o último ponto onde as duas branches eram iguais. Este é o famoso `merge` de três vias, muito prazer. O Git olha para:

1. O commit na Branch A (onde você está);
2. O commit na Branch B (que você quer trazer);
3. O Ancestral Comum entre ambas.

```bash
# Terminando uma feature na Branch B:
$ git commit -m "Finish a feature"

# Voltando para a Branch A e puxando a feature da Branch B:
$ git switch branch-a
$ git merge branch-b

# deletando Branch B, já fundida com a Branch A:
$ git branch -d branch-b
```

Note que o Git na "reclama" que você usou `git branch -d` para deletar, porque ela está devidamente "mergeada". Se uma linha mudou na Branch B, mas não na A (em relação ao ancetral), o Git aplica a mudança. Se mudou em ambas de forma diferente... Bem, aí voltamos ao Capítulo 3 e aos conflitos que tanto te assustam.

### 5.2 O Dilema do Fast-Forward vs. No-Fast-Foward (`--no-ff`)

Esse tópico volta a assombrar seus sonhos de deixar de ser um "script kid" para se tornar um arquiteto de software, mas não vamos deixar algo simples te prenda. O Git, por padrão, tenta ser "preguiçoso" usando o Fast-Foward.

### 5.2.1 Por que o Fast-Forward pode ser um erro?

Se a história é linear, o Git apenas move o ponteiro `main` para o topo da funcionalidade. Visualmente, parece que você nunca saiu da `main`. Se você tiver 10 commits pequenos e experimentais, eles "derretem" no histórico principal. Você perde a noção semântica de "aqui começou a feat x; e aqui ela terminou".

### 5.2.2 A Flag `--no-ff` e o "Padrão GitHub"

Desenvolvedores com mais experiência - e você, um dia, se seguir as dicas desse manual - costumam usar a flag `--no-ff`. Isso força o Git a criar um **Merge Commit**, mesmo que não fosse estritamente necessário, mas para delimitar as partes de um processo de desenvolvimento.

```bash
$ git merge --no-ff <branch>
```

O que o GitHub tem a ver com isso? Jovem, se você já usou o GitHub, deve ter notado que, ao aceitar um **Pull Request** pelo botãozinho verde, o histórico ganha um commit extra dizendo "*Merge pull request #1 from...*". Isso acontece porque o padrão do GitHub é o **Merge Commit** (`--no-ff`). Você acabou de apreder o truque por trás de uma das "mágicas" da plataforma.

O GitHub faz isso de propósito: ele quer garantir que a "bolha" daquela funcionalidade fique registrada no histórico, facilitando a reversão e a leitura do que foi entregue em cada tarefa. Um iniciante pode achar que é poluição, mas para um desenvolvedor intermediário, é rastro de auditoria. Não esqueça.

### 5.3 Squash Merging: A Arte da Limpeza

Muitas vezes, a sua branch de funcionalidade se torna um caos. Commits como "corrigindo erro", "ajuste de código", "agora vai" são comuns (esse último eu espero que não!). Levar esse lixo para a `main` é falta de etiqueta técnica, quando você trabalha em uma equipe ativa.

O **Squash Merge** pega todos os seus commits da branch e os "esmaga" em um único commit gigante antes de o unir à `main`. No GitHub, esta é uma opção comum pra manter o histórico da branch principal extremamente limpo, mas cuidado: você perde o detalhamento do que foi feito passo a passo, consequentemente, impossibilitando o uso de alguns comandos. Então use-o com sabedoria.

```bash
$ git merge --squash branch-bagunçada
$ git commit -m "feat: implement new log system (final version)"
```

### 5.4 Estratégias de Merge: Do Legado à Próxima Geração

Você já deve ter visto o Git mencionar que está usando uma "estratégia" durante um merge. No nível intermediário, é fundamental entender o que acontece no "motor" do Git.

### 5.4.1 A Estratégia `recursive` (O Velho Guerreiro) 

Durante anos, a estratégia `recursive` foi o padrão absoluto do Git. Ela é famosa por lidar com situações complexas de "merges cruzados" (onde existem múltiplos ancestrais comuns). Nesses casos, a `recursive` cria um **commit de base virtual** que une esses ancestrais antes de tentar o merge final. Embora confiável, ela é notavelmente lenta em repositórios gigantescos e, ás vezes, falha em detectar renomeações de arquivos de forma precisa.

### 5.4.2 O Reinado de `ORT` (O Gêmeo Ostensivo)

A partir da versão 2.35, o Git introduziu e tornou padrão a estratégia `ORT` (acrônimo para *Ostensible Recursive's Twin* ou "Gêmeo Ostensivo do Recursivo"). Como o próprio nome esquisito indica, ela foi projetada para ser a sucessora direta da `recursive`, corrigindo suas falhas fundamentais.

- **Merge "Ortogonal":** O nome `ORT` também brinca com a idéia de ser um merge "ortogonal" e superior, resolvendo quase todos os conflitos de renomeação que travaram o motor anitgo;
- **Performance Massiva:** A `ORT` foi reescrita para ser eficiente. Em repositórios de escala industrial, ela chega a ser **centenas de vezes mais rápida** que a `recursive`;
- **Segurança e Limpeza:** Ela foi desenhada para ser "correta por construção", garantindo que o diretório de trabalho não fique sujo com arquivos temporários se algo der errado no processo.

Saber que o Git agora usa `ORT` por padrão mostra que você entende a evolução da engenharia por trás do controle de versão.

### 5.5 Merge vs. Rebase: A Batalha Ideológica

De forma resumida, pra não prologar mais esse tema:

- Merge: É "honesto". Mantém a cronologia real e o rastro de quadro as coisas foram integradas;
- Rebase: É "estético". Reescreve a história para parecer linear.

> **A Regra de Ouro:** Nunca faça `rebase` em branches públicas. Guarde o `rebase` para limpar sua bagunça local antes de fazer o merge final.

Dominar o `--no-ff` e entender as estratégias de merge te dá o controle sobre como a história do seu próprio projeto será lida. No próximo capítulo, vamos ver como esta técnica se torna o centro da colaboração profissional através dos **Pull Requests**.
