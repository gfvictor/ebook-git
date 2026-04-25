# Git: Versionamento de Código & Fluxo de Trabalho
## A Trilogia

Este repositório contém o código-fonte de automação e materiais didáticos da trilogia de e-books sobre Git e fluxos de trabalho colaborativos. Este projeto foi desenvolvido como parte das **Atividades de Extensão Acadêmica** do curso de **Ciência da Computação** da **UNIP (Universidade Paulista)**.

O objetivo é levar o estudante do absoluto zero - o caos dos arquivos soltos nos diretórios locais - até o domínio de engenharia de software distribuída.

---
## Estrutura da Obra

O projeto é dividido em três volumes modulares, organizados por nível de proficiência:

- **Volume I: Iniciante - Do Caos ao Primeiro Commit.** Focado em fundamentos locais (`add`, `commit`, `restore`, `reset`), filosofia de snapshots, e a configuração de um ambiente de trabalho saudável (SSH e `git config`);
- **Volume II: Intermediário - A Era da Colaboração.** Focado na anatomia da sincronização (`fetch`, `pull`, `push`), estratérias de `merge` vs. `rebase`, e resolução de conflitos em equipe;
- **Volume III: Avançado - Engenharia de Fluxo e Auditoria (wip - título provisório)**. Aborda manipulação de histórico (`reflog`, `bisect`, `interactive rebase`), correções com `cherry-pick`, Git Hooks, e automação de CI/CD.

---
## Pré-requisitos e Instalação

Para compilar estes livros a partir do código-fonte, usando o script de compilação disponível no projeto,  você precisará dos pacotes: 

- **Pandoc:** o canivete suiço de documentos;
- **Tectonic:** um motor LaTeX moderno e auto-gerenciado;
- **Lua:** uma linguagem escrita em ANSI C, extremamente leve que pode ser compilada em qualquer plataforma.

1. Instalação do Ambiente

### No macOS (via Homebrew):
```bash
$ brew install pandoc tectonic lua
```

### No Linux (Debian/Ubuntu):
```bash
$ sudo apt install pandoc lua5.4
# Para o Tectonic, siga as instruções em tectonic-typesetting.github.io
```

### No Android (Termux):
```bash
$ pkg install pandoc tectonic lua
```

2. Estrutura de Arquivos

Certifique-se de manter a pasta `shared/` sempre na raiz, pois ela contém o motor visual (`base_style.yaml`) que garante a identidade visual em todos os volumes. Caso você queria usar suas próprias configurações, basta editar o arquivo usando parametros LaTeX. Para referências de alinhamento de texto e uso de cores em LaTeX:

- [LaTeX - Alinhamento de Textohttps] (//www.overleaf.com/learn/latex/Text_alignment "LaTeX - Text Alignment")
- [LaTeX - Uso de Cores] (https://www.overleaf.com/learn/latex/Using_colors_in_LaTeX "LaTeX - Using Colors")

---
## Como Gerar os PDFs:

Esqueça comandos manuais gigantescos. O repositórios utiliza um script de automação em **Lua** que lida com a lógica de compilação, metadados e arquivos opcionais.

Para compilar um volume especifíco, utilize:
```bash
$ lua build.lua <númedo do volume>

# Por exemplo, para o Volume I:
$ lua build.lua 1
```

O PDF resultante será gerado automaticamente na pasta `output/`. O script é inteligente o suficiente para detectar se você já escreveu o capítulo bônus ou as referências; caso não existam, o build continuará normalmente ignorando as ausências.

> Em caso de erros de compilação em decorrência de erro no script `build.lua`, por favor abre um *Issue* e comunique o problema. Obrigado.

## Extensão Acadêmica (UNIP)

Este material foi concebido para democratizar o conhecimento técnico dentro da comunidade acadêmica, servindo como guia de consulta rápida e manual de boas práticas de software em grupo, com uma linguagem leve e descontraída para suavizar a leitura.

**Autor:** Victor Gama de Farias
**Curso:** Ciência da Computação - UNIP
**Contato:** gfvictor@pm.me
