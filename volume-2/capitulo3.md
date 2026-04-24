\newpage

# Capítulo III
\vspace{-1em}
## Gestão e Resolução de Conflitos e Crises
\vspace{1em}

Jovem, se você ainda não encarou um conflito de merge (mesmo que seja no seu próprio projeto solo, por organização de menos e café demais), você ainda não trabalhou em um projeto real. No momento em que você deixa de ser um desenvolvedor solitário e passa a integrar uma equipe, o Git deixa de ser apenas sobre versionamento e passa a ser sobre diplomacia técnica. Conflitos são o preço que se paga pela colaboração paralela.

### 3.1 O que é, Afinal, um Conflito?

Um conflito ocorre quando o Git tenta fundir duas histórias (via `merge` ou `git pull --rebase`) e descobre que a mesma linha de um arquivo foi alterada de formas diferentes em ambas as ramificações.

O Git é inteligente, mas ele não é telepata. Ele não sabe se a versão correta é a sua, a do coleguinha ou uma mistura das duas. Nesses casos, ele para o processo, cruza os braços e diz: "Resolve você, porque eu é que não vou adivinhar".

### 3.2 A Anatomia do Caos: Entendendo Marcadores


