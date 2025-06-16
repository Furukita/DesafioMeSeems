# Desafio Técnico MeSeems

Projeto de demonstração desenvolvido para o processo seletivo MeSeems.

## Como Executar
- Clone este repositório
- Abra no Android Studio ou XCode o diretório referente a cada SO
- Execute em um emulador ou dispositivo físico

## Funcionalidades
- Listagem de pesquisas com:
    - Título
    - Tempo estimado
    - Recompensa
    - Botão "Responder"
- Popup de confirmação ao clicar em **"RESPONDER"** (simula início da pesquisa)
- Dados carregados localmente a partir de `res/raw/surveys.json`(Android) e `Res/surveys.json`(iOS)
- Suporte completo a:
    - Tema claro e escuro
    - Acessibilidade (compatível com TalkBack/VoiceOver)
    - Tamanhos de fonte do sistema
    - Layout responsivo para diferentes tamanhos de tela
- Scroll suave e otimizado

## Tecnologias Utilizadas Android
- **Kotlin**
- **MVVM**
- **ViewModel + LiveData**
- **RecyclerView**
- **Material Design**
- **Gson** (leitura de JSON mockado)
- Suporte a **tema dinâmico** e **acessibilidade**


## Tecnologias Utilizadas iOS
- **Swift**
- **MVVM**
- **UIKit + Storyboard**
- **UITableView**
- Suporte a **tema dinâmico** e **acessibilidade**