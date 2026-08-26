# 🌌 Servidor Self-Host (Media & Homelab)

![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Cloudflare](https://img.shields.io/badge/Cloudflare-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white)
![Jellyfin](https://img.shields.io/badge/Jellyfin-000B25?style=for-the-badge&logo=Jellyfin&logoColor=00A4DC)

Repositório de infraestrutura do meu servidor doméstico. Este repositório armazena as receitas (`docker-compose.yml`) de todos os serviços que rodam no meu homelab, gerenciado através do **CasaOS** no **Ubuntu Server**.

## 🚀 Serviços Hospedados

A stack principal é voltada para a automação de mídia (The "Arr" Stack), com regras customizadas para priorizar conteúdo localizado e qualidade de vídeo:

*   **[Sonarr](https://sonarr.tv/):** Automação e gerenciamento de Séries e Animes. Configurado com *Custom Formats* rigorosos para capturar releases com legendas embutidas (`Multi-Sub`, `Erai-raws`) e áudio PT-BR.
*   **[Bazarr](https://www.bazarr.media/):** Busca automatizada de legendas complementares.
*   **[Prowlarr](https://prowlarr.com/):** Gerenciador central de indexadores e trackers (ex: Nyaa).
*   **[qBittorrent](https://www.qbittorrent.org/):** Cliente de download focado em performance.
*   **[Jellyfin](https://jellyfin.org/):** Media server de código aberto para streaming inteligente do conteúdo baixado.

## 🛡️ Segurança e Acesso Remoto

Nenhuma porta do servidor é exposta diretamente à internet. O acesso externo aos painéis de gerência e aos serviços é feito através do **Cloudflare Zero Trust (Tunnels)**:
*   Acesso web restrito via autenticação OTP (One-Time PIN) por e-mail.
*   Túneis HTTP diretos para os containers.
*   Acesso SSH remoto via Cloudflare Tunnels e Termius.

## 📂 Estrutura do Repositório

Cada serviço possui sua própria pasta contendo o arquivo `docker-compose.yml` correspondente.

```text
📦 Projeto-de-Servidor-Self-Host
┣ 📂 sonarr/
┃ ┗ 📜 docker-compose.yml
┣ 📂 qbittorrent/
┃ ┗ 📜 docker-compose.yml
┣ 📂 prowlarr/
┃ ┗ 📜 docker-compose.yml
┣ 📂 bazarr/
┃ ┗ 📜 docker-compose.yml
┣ 📂 jellyfin/
┃ ┗ 📜 docker-compose.yml
┗ 📜 README.md
```

## 🔗 Passo a Passo: Integração e Configuração

### 1. Configurar Trackers no Prowlarr
*   Acesse a interface do Prowlarr.
*   Navegue até `Indexers` e clique em `Add Indexer` (ícone de `+`).
*   Pesquise os trackers desejados (ex: Nyaa para animes, TorrentLeech para torrents no geral).
*   Configure as credenciais, se exigido pelo tracker privado.
*   Clique em `Test` e depois em `Save`.

### 2. Vincular Prowlarr ao Sonarr
*   No Sonarr, vá em `Settings` > `General` e copie a `API Key`.
*   No Prowlarr, vá em `Settings` > `Apps`.
*   Clique em `+` (Add App) e selecione `Sonarr`.
*   Preencha o campo `Prowlarr Server` com a URL do Prowlarr (ex: `http://prowlarr:9696`).
*   Preencha o campo `Sonarr Server` com a URL do Sonarr (ex: `http://sonarr:8989`).
*   Cole a `API Key` do Sonarr copiada anteriormente.
*   Clique em `Test`, salve e clique no botão `Sync App Indexers` para enviar os trackers ao Sonarr.

### 3. Configurar qBittorrent no Sonarr
*   Acesse a interface do Sonarr.
*   Navegue até `Settings` > `Download Clients`.
*   Clique em `+` e escolha `qBittorrent`.
*   Insira o `Host` (ex: `qbittorrent`), `Port` (padrão 8080), além do seu usuário e senha do qBittorrent.
*   Clique em `Test` e em seguida `Save`.

### 4. Integrar Bazarr ao Sonarr
*   No Bazarr, vá em `Settings` > `Sonarr`.
*   Ative a integração marcando a opção `Enabled`.
*   Preencha o `Address` (ex: `sonarr`), a porta (`8989`) e cole a `API Key` do Sonarr.
*   Clique em `Test` e depois salve as configurações.

### 5. Configurar Bibliotecas no Jellyfin
*   Acesse a interface do Jellyfin.
*   Vá em `Painel de Controle` > `Bibliotecas`.
*   Clique em `Adicionar Biblioteca de Mídia` e escolha o tipo (ex: Séries/Programas).
*   Clique em `Pastas` e selecione o diretório mapeado onde o Sonarr organiza as mídias renomeadas.
*   Ajuste as preferências de idioma e metadados.
*   Salve para iniciar a varredura automática do conteúdo baixado.
